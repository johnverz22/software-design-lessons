from sqlalchemy import Column, Integer, String, Boolean
from .database import Base

class Fruit(Base):
    __tablename__ = "fruits"

    id = Column(Integer, primary_key=True, index=True)
    name = Column(String(100))
    seedless = Column(Boolean, default=True)
    image_path = Column(String(100), default=None)