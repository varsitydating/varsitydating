import 'dart:io';
import 'package:amplify_flutter/amplify_flutter.dart';

class StorageService {
  /// Upload a file to S3 and return the unique file path.
  static Future<String> uploadFile(File file, {required String fileKey}) async {
    try {
      // Step 1: Generate a unique file path
      final uniqueFileName =
          'profile-images/${DateTime.now().millisecondsSinceEpoch}_${file.path.split('/').last}';

      // Step 2: Upload the file to S3
      Amplify.Storage.uploadFile(
        localFile: AWSFile.fromPath(file.path),
        path: StoragePath.fromString(uniqueFileName), // Use StoragePath
      );

      // Return the unique file path
      return uniqueFileName;
    } catch (e) {
      throw Exception('Error uploading file: $e');
    }
  }
}
