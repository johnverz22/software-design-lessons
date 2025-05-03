// (1) Import necessary packages
import 'package:flutter/material.dart'; // For building UI
import 'dart:io'; // To work with files like images
import 'package:image_picker/image_picker.dart'; // To capture images from camera
import 'package:app1/services/api_service.dart'; // Custom service to save data to backend
import 'package:app1/config/theme.dart'; // Custom theme definitions

// (2) Create a StatefulWidget for the fruit creation screen
class CreateFruitsScreen extends StatefulWidget {
  const CreateFruitsScreen({super.key});

  @override
  State<CreateFruitsScreen> createState() => _CreateFruitsScreenState();
}

// (3) Define the state logic for the CreateFruitsScreen
class _CreateFruitsScreenState extends State<CreateFruitsScreen> {
  // (4) Initialize controllers and state variables
  final _formKey = GlobalKey<FormState>(); // For validating form input
  final _nameController = TextEditingController(); // To read the name input
  bool _seedless = false; // Switch for seedless property
  File? _image; // To store captured image
  final ApiService _apiService = ApiService(); // For saving fruit to API
  bool _isLoading = false; // To show loading indicator

  // (5) Method to open the camera and capture image
  Future<void> _takePicture() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path); // Store image file
      });
    }
  }

  // (6) Method to validate and save fruit to the backend
  Future<void> _saveFruit() async {
    if (_formKey.currentState!.validate()) {
      if (_image == null) {
        // Alert user to take a photo
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please take a photo of the fruit')),
        );
        return;
      }

      setState(() {
        _isLoading = true; // Show loading indicator
      });

      try {
        await _apiService.createFruit(
          _nameController.text,
          _seedless,
          _image!,
        );

        if (!mounted) return; // If widget is not mounted, return
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Fruit saved successfully'),
            backgroundColor: Theme.of(context).colorScheme.success,
          ),
        );

        // (7) Reset form after successful save
        _nameController.clear();
        setState(() {
          _seedless = false;
          _image = null;
          _isLoading = false;
        });
      } catch (e) {
        setState(() {
          _isLoading = false;
        });
        if (!mounted) return; // If widget is not mounted, return
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error saving fruit: ${e.toString()}'),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    }
  }

  // (8) Build UI using form and widgets
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: _isLoading
          ? const Center(child: CircularProgressIndicator()) // Loading screen
          : SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Form(
                key: _formKey, // Attach form key for validation
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 100),
                    Text('New Fruit',
                        style: Theme.of(context)
                            .textTheme
                            .displayMedium
                            ?.copyWith(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.onPrimary,
                            )),
                    const SizedBox(height: 30),

                    // (9) Input field for fruit name
                    Text('Name',
                        style: theme.textTheme.displayMedium?.copyWith(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                              color: Theme.of(context).colorScheme.tertiary,
                              width: 2),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a fruit name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 30),

                    // (10) Toggle switch for "seedless"
                    Card(
                      elevation: 0,
                      margin: EdgeInsets.zero,
                      color: theme.colorScheme.surface,
                      clipBehavior: Clip.antiAlias,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      child: SwitchListTile(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        tileColor: Colors.transparent,
                        title: Text('Seedless',
                            style: theme.textTheme.displayMedium?.copyWith(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                        value: _seedless,
                        onChanged: (value) {
                          setState(() {
                            _seedless = value;
                          });
                        },
                        activeColor: theme.colorScheme.tertiary,
                        activeTrackColor: Colors.grey.shade300,
                      ),
                    ),
                    const SizedBox(height: 30),

                    // (11) Image capture section
                    Text('Photo',
                        style: theme.textTheme.displayMedium?.copyWith(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    InkWell(
                      onTap: _takePicture,
                      child: Container(
                        height: 200,
                        decoration: BoxDecoration(
                          color: theme.cardColor,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            style: BorderStyle.solid,
                            color: theme.colorScheme.secondary
                                .withValues(alpha: .5),
                          ),
                        ),
                        child: _image == null
                            ? Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.camera_alt,
                                        size: 64,
                                        color: theme.colorScheme.secondary
                                            .withValues(alpha: .3)),
                                    const SizedBox(height: 16),
                                    Text('Take Photo',
                                        style: theme.textTheme.titleMedium
                                            ?.copyWith(
                                                color: theme
                                                    .colorScheme.secondary
                                                    .withOpacity(0.3))),
                                  ],
                                ),
                              )
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Stack(
                                  alignment: Alignment.bottomRight,
                                  children: [
                                    Image.file(_image!,
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                        height: double.infinity),
                                    Positioned(
                                      right: 8,
                                      bottom: 8,
                                      child: ElevatedButton.icon(
                                        onPressed: _takePicture,
                                        icon: const Icon(Icons.refresh),
                                        label: const Text('Retake'),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: theme
                                              .colorScheme.tertiary
                                              .withValues(alpha: .8),
                                          minimumSize: const Size(0, 36),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                      ),
                    ),
                    const SizedBox(height: 36),

                    // (12) Submit button
                    ElevatedButton.icon(
                      onPressed: _saveFruit,
                      icon: const Icon(Icons.save),
                      label: const Text('Save'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: theme.colorScheme.tertiary,
                        minimumSize: const Size(double.infinity, 48),
                        textStyle:
                            theme.textTheme.bodyMedium?.copyWith(fontSize: 16),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  // (13) Clean up the controller when widget is destroyed
  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }
}
