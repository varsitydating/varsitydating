import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:amplify_flutter/amplify_flutter.dart';

class AuthenticationController extends GetxController {
  static AuthenticationController authController = Get.find();

  late Rx<File?> pickedFile;
  File? get profileImage => pickedFile.value;
  XFile? imageFile;

  // Check if the user's profile is complete
  Future<bool> isProfileComplete() async {
    try {
      final userId = await getCurrentUserId();
      final request = GraphQLRequest<String>(
        document: '''
          query GetUserProfile(\$id: ID!) {
            getUserProfile(id: \$id) {
              isProfileComplete
            }
          }
        ''',
        variables: {"id": userId},
      );

      final response = await Amplify.API.query(request: request).response;

      // Check and cast the response data
      if (response.data != null) {
        final dynamic data = jsonDecode(response.data!);
        final isComplete = data['getUserProfile']?['isProfileComplete'];
        return isComplete == true;
      }
      return false;
    } catch (e) {
      print("Error checking profile completion: $e");
      return false;
    }
  }

  pickImageFileFromGallery() async {
    final ImagePicker picker = ImagePicker();
    imageFile = await picker.pickImage(source: ImageSource.gallery);

    if (imageFile != null) {
      Get.snackbar(
          "Profile Image", "You have successfully updated your profile image");
      pickedFile = Rx<File?>(File(imageFile!.path));
    }
  }

  captureImageFromPhoneCamera() async {
    final ImagePicker picker = ImagePicker();
    imageFile = await picker.pickImage(source: ImageSource.camera);

    if (imageFile != null) {
      Get.snackbar(
          "Profile Image", "You have successfully updated your profile image");
      pickedFile = Rx<File?>(File(imageFile!.path));
    }
  }

  // Helper method to fetch the current user's ID
  Future<String> getCurrentUserId() async {
    final user = await Amplify.Auth.getCurrentUser();
    return user.userId;
  }
}
