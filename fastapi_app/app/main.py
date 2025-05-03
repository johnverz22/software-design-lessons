from fastapi import FastAPI, HTTPException, Depends, File, UploadFile, Form
from sqlalchemy.orm import Session
from fastapi.staticfiles import StaticFiles
from typing import Optional
import shutil
import os
from pathlib import Path
from .models import Fruit
from .schemas import FruitCreate, FruitOut
from .database import get_db

app = FastAPI()

# Set the base and upload directory for saving images
BASE_DIR = Path(__file__).resolve().parent.parent
UPLOAD_DIR = os.path.join(BASE_DIR, "uploads")
os.makedirs(UPLOAD_DIR, exist_ok=True)  # Create the directory if it doesn't exist

# Serve uploaded images as static files
app.mount("/static/uploads", StaticFiles(directory=UPLOAD_DIR), name="uploads")

@app.get("/")
def index():
    return {"message": "Welcome to FastAPI"}

# Route to create a new fruit record
@app.post("/new")
async def create(
    name: str = Form(...),               # Get name from form input
    seedless: bool = Form(...),          # Get seedless as a boolean from form
    image: Optional[UploadFile] = File(None),  # Optional file input for image
    db: Session = Depends(get_db)        # Get database session
):
    # Create a new fruit instance
    new_fruit = Fruit(name=name, seedless=seedless)
    
    if image:  # If image is uploaded
        file_location = f"uploads/{name}_{image.filename}"  # Create unique file name
        with open(file_location, "wb") as buffer:           # Save the file
            shutil.copyfileobj(image.file, buffer)
        new_fruit.image_path = file_location  # Save file path in database
    
    db.add(new_fruit)       # Add new fruit to DB session
    db.commit()             # Commit changes
    db.refresh(new_fruit)   # Refresh to get new DB values

    return {"status": "success", "detail": "Fruit is successfully saved."}

@app.get("/fruits", response_model=list[FruitOut])
def get_fruits(db: Session = Depends(get_db)):
    fruits = db.query(Fruit).all()
    return fruits

@app.get("/fruits/{fruit_index}", response_model=FruitCreate) 
def get_fruit(fruit_index: int) -> FruitCreate:
    if(fruit_index < len(fruits)):
        return fruits[fruit_index]
    else:
        raise HTTPException(status_code=404, detail="Fruit is missing")