import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class ImageUploader {
  final _storage = FirebaseStorage.instance;

  Future<String?> uploadImage(File imageFile) async {
    try {
      final Reference ref =
          _storage.ref().child('images/${DateTime.now()}.jpg');
      final UploadTask uploadTask = ref.putFile(imageFile);
      final TaskSnapshot storageSnapshot = await uploadTask;
      final downloadUrl = await storageSnapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print('Error uploading image: $e');
      return null;
    }
  }
}
