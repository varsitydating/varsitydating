import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:varsitydating/services/storage_service.dart';
import 'package:varsitydating/models/UserProfile.dart' as custom_model;
import 'package:varsitydating/homeScreen/swipeable_profiles_screen.dart';

class ProfileImageScreen extends StatefulWidget {
  const ProfileImageScreen({super.key});

  @override
  _ProfileImageScreenState createState() => _ProfileImageScreenState();
}

class _ProfileImageScreenState extends State<ProfileImageScreen> {
  final List<File?> _images = [null, null, null, null, null, null];
  final _picker = ImagePicker();
  final Uuid _uuid = Uuid();
  bool _isUploading = false;

  TextEditingController dobController = TextEditingController();

  // Save user profile with uploaded image URLs
  Future<void> saveUserProfile(List<String> imageUrls) async {
    try {
      final userId = await Amplify.Auth.getCurrentUser().then((user) => user.userId);

      // Create or update the UserProfile object
      final userProfile = custom_model.UserProfile(
        id: userId,
        profileImageURLs: imageUrls,
        name: '',
        surname: '',
        gender: '',
        country: '',
        phoneNumber: '',
        email: '',
        isProfileComplete: true, dob: null,
      );

      // Save to Amplify DataStore
      await Amplify.DataStore.save(userProfile);

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Profile saved successfully!")),
      );

      // Navigate to SwipeableProfilesScreen
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SwipeableProfilesScreen()),
      );
    } catch (e) {
      // Handle errors during the save process
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to save profile: $e")),
      );
    }
  }

  // Image picking logic
  Future<void> _pickImage(int index) async {
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        final file = File(pickedFile.path);

        // Validate file size (max 5MB)
        if (file.lengthSync() > 5 * 1024 * 1024) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Image size should not exceed 5MB')),
          );
          return;
        }

        setState(() {
          _images[index] = file;
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error picking image: $e')),
      );
    }
  }

  // AWS Image upload logic
  Future<String?> _uploadImageToAWS(File image) async {
    try {
      final fileKey = "${_uuid.v4()}-${image.path.split('/').last}";
      final uploadedFilePath = await StorageService.uploadFile(image, fileKey: fileKey);
      return uploadedFilePath;
    } catch (e) {
      print('Failed to upload image: $e');
      return null;
    }
  }

  // Handle multiple image uploads
  Future<void> _uploadImages() async {
    if (_images.where((image) => image != null).length < 2) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please upload at least 2 images')),
      );
      return;
    }

    setState(() {
      _isUploading = true;
    });

    List<String> imageUrls = [];

    try {
      for (var image in _images) {
        if (image != null) {
          final uploadedUrl = await _uploadImageToAWS(image);
          if (uploadedUrl != null) {
            imageUrls.add(uploadedUrl);
          }
        }
      }

      if (imageUrls.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No images were uploaded successfully')),
        );
        return;
      }

      // Save user profile with uploaded URLs
      await saveUserProfile(imageUrls);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error uploading images: $e')),
      );
    } finally {
      setState(() {
        _isUploading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload Profile Images'),
        backgroundColor: const Color.fromARGB(255, 243, 177, 33),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset("images/logo.png", width: 200),
            const SizedBox(height: 20),
            const Text(
              "Welcome to Varsity Dating",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              "The campus is buzzing. Complete your profile to connect with your crush!",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: 6,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => _pickImage(index),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.blue),
                        borderRadius: BorderRadius.circular(10),
                        image: _images[index] != null
                            ? DecorationImage(
                                image: FileImage(_images[index]!),
                                fit: BoxFit.cover,
                              )
                            : null,
                      ),
                      child: _images[index] == null
                          ? const Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.add_a_photo),
                                  SizedBox(height: 5),
                                  Text('Tap to upload'),
                                ],
                              ),
                            )
                          : null,
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            _isUploading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: _uploadImages,
                    child: const Text('Submit Images'),
                  ),
          ],
        ),
      ),
    );
  }
}
