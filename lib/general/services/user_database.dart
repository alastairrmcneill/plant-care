import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:plant_care/general/models/models.dart';
import 'package:plant_care/general/services/auth_service.dart';
import 'package:plant_care/general/services/storage_service.dart';

class UserDatabase {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;
  static final CollectionReference _usersRef = _db.collection('users');

  static Future createUser(BuildContext context, {required AppUser appUser, required File? image}) async {
    String? imageUrl;
    // Upload image
    if (image != null) {
      imageUrl = await StorageService.uploadUserImage(image);
    }

    AppUser newAppUser = appUser.copy(photoUrl: imageUrl);
    // Save to Database
    DocumentReference ref = _usersRef.doc(newAppUser.uid);

    ref.set(newAppUser.toJSON());

    // Update notifier
  }

  static Future<AppUser?> readUser(BuildContext context, {required String uid}) async {
    DocumentReference ref = _usersRef.doc(uid);
    DocumentSnapshot snapshot = await ref.get();
    if (snapshot.exists) {
      Map<String, dynamic> data = snapshot.data()! as Map<String, dynamic>;
      AppUser user = AppUser.fromJson(data);
      return user;
    }
    return null;
  }

  static Future updateUser(BuildContext context, AppUser appUser) async {
    DocumentReference ref = _usersRef.doc(appUser.uid);

    await ref.set(appUser.toJSON(), SetOptions(merge: true));
  }
}
