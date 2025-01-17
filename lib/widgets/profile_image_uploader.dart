import 'dart:io';
import 'package:flutter/material.dart';
import 'package:varsitydating/services/storage_service.dart';
import 'package:varsitydating/controllers/authentication_controller.dart';

class ProfileImageUploader extends StatefulWidget {
  final Function(String) onImageUploaded;

  const ProfileImageUploader({super.key, required this.onImageUploaded});

  @override
  _ProfileImageUploaderState createState() => _ProfileImageUploaderState();
}

class _ProfileImageUploaderState extends State<ProfileImageUploader> {
  File? _imageFile;
  String? _uploadedImageUrl;

  /// Pick an image from the gallery and upload it to S3
  Future<void> pickAndUploadImage() async {
    try {
      // Show loading indicator
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => const Center(child: CircularProgressIndicator()),
      );

      // Pick an image
      final pickedFile = await AuthenticationController.authController.pickImageFileFromGallery();
      if (pickedFile == null) return;

      setState(() {
        _imageFile = File(pickedFile.path);
      });

      // Upload the file using StorageService
      final uploadedUrl = await StorageService.uploadFile(_imageFile!, fileKey: '');

      setState(() {
        _uploadedImageUrl = uploadedUrl;
      });

      // Notify parent widget of the uploaded URL
      widget.onImageUploaded(uploadedUrl);
    } catch (e) {
      print('Error uploading image: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Image upload failed: $e")),
      );
    } finally {
      // Hide loading indicator
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'UPLOAD PROFILE IMAGE',
          style: TextStyle(
            color: Color.fromARGB(255, 241, 141, 47),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16.0),
        GestureDetector(
          onTap: pickAndUploadImage,
          child: Container(
            height: 180,
            width: 120,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(12),
              image: _uploadedImageUrl != null
                  ? DecorationImage(
                      image: NetworkImage(_uploadedImageUrl!),
                      fit: BoxFit.cover,
                    )
                  : (_imageFile != null
                      ? DecorationImage(
                          image: FileImage(_imageFile!),
                          fit: BoxFit.cover,
                        )
                      : const DecorationImage(
                          image: AssetImage('assets/default_profile.png'),
                          fit: BoxFit.cover,
                        )),
            ),
          ),
        ),
        const SizedBox(height: 16.0),
      ],
    );
  }
}
