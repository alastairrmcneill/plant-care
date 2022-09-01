import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

class StorageService {
  static final FirebaseStorage _storage = FirebaseStorage.instance;

  static Future<File> _compressImage(String imageId, File image) async {
    final tempDir = await getTemporaryDirectory();
    final path = tempDir.path;

    File? compressedImageFile = await FlutterImageCompress.compressAndGetFile(
      image.absolute.path,
      '$path/image_$imageId.jpg',
      quality: 50,
    );

    return compressedImageFile!;
  }

  static Future<String> _uploadImage(String path, String imageId, File image) async {
    UploadTask uploadTask = _storage.ref().child(path).putFile(image);

    TaskSnapshot storageSnap = await uploadTask.whenComplete(() => null);

    String downloadUrl = await storageSnap.ref.getDownloadURL();

    return downloadUrl;
  }

  static Future<String> uploadUserImage(File imageFile) async {
    String imageId = Uuid().v4();

    File image = await _compressImage(imageId, imageFile);

    String downloadUrl = await _uploadImage(
      'images/users/user_$imageId.jpg',
      imageId,
      image,
    );
    return downloadUrl;
  }

  static Future<String> uploadPlantImage(File imageFile) async {
    String imageId = Uuid().v4();

    File image = await _compressImage(imageId, imageFile);

    String downloadUrl = await _uploadImage(
      'images/plants/plant_$imageId.jpg',
      imageId,
      image,
    );
    return downloadUrl;
  }
}
