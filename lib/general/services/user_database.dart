import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:plant_care/general/models/models.dart';
import 'package:plant_care/general/notifiers/notifiers.dart';
import 'package:plant_care/general/services/auth_service.dart';
import 'package:plant_care/general/services/storage_service.dart';
import 'package:plant_care/general/widgets/widgets.dart';
import 'package:provider/provider.dart';

class UserDatabase {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;
  static final CollectionReference _usersRef = _db.collection('users');

  // Create User
  static Future createUser(BuildContext context, {required AppUser appUser, required File? image}) async {
    String? imageUrl;
    // Upload image
    try {
      if (image != null) {
        imageUrl = await StorageService.uploadUserImage(image);
      }

      AppUser newAppUser = appUser.copy(photoUrl: imageUrl);

      // Save to Database
      DocumentReference ref = _usersRef.doc(newAppUser.uid);

      ref.set(newAppUser.toJSON());
    } on FirebaseException catch (error) {
      showErrorDialog(context, error.message!);
    }
  }

  // Read User
  static Future readCurrentUser(BuildContext context) async {
    // Create notifiers
    final user = Provider.of<User?>(context, listen: false);
    UserNotifier userNotifier = Provider.of<UserNotifier>(context, listen: false);
    if (user == null) return;

    // Get current user id
    String userId = user.uid;

    try {
      // Read database
      DocumentReference ref = _usersRef.doc(userId);
      DocumentSnapshot snapshot = await ref.get();

      // Create app user

      if (snapshot.exists) {
        Map<String, dynamic> data = snapshot.data()! as Map<String, dynamic>;
        AppUser user = AppUser.fromJson(data);

        // Update notifier
        userNotifier.setCurrentUser = user;
      }
    } on FirebaseException catch (error) {
      showErrorDialog(context, error.message!);
    }
  }

  static Future<AppUser?> readUser(BuildContext context, {required String uid}) async {
    try {
      DocumentReference ref = _usersRef.doc(uid);
      DocumentSnapshot snapshot = await ref.get();
      if (snapshot.exists) {
        Map<String, dynamic> data = snapshot.data()! as Map<String, dynamic>;
        AppUser user = AppUser.fromJson(data);
        return user;
      }
      return null;
    } on FirebaseException catch (error) {
      showErrorDialog(context, error.message!);
    }
  }

  // Update User
  static Future updateUser(BuildContext context, AppUser appUser) async {
    try {
      DocumentReference ref = _usersRef.doc(appUser.uid);

      await ref.set(appUser.toJSON(), SetOptions(merge: true));
    } on FirebaseException catch (error) {
      showErrorDialog(context, error.message!);
    }
  }

  static Future removeToken(BuildContext context, {required String uid}) async {
    try {
      DocumentReference ref = _usersRef.doc(uid);
      await ref.update({'token': ''});
    } on FirebaseException catch (error) {
      if (error.code == "not-found") return;
      showErrorDialog(context, error.message!);
    }
  }

  static Future setToken(BuildContext context, {required String uid, required String token}) async {
    try {
      DocumentReference ref = _usersRef.doc(uid);
      await ref.update({'token': token});
    } on FirebaseException catch (error) {
      showErrorDialog(context, error.message!);
    }
  }

  // Delete User
  static Future deleteUser(BuildContext context, {required String uid}) async {
    try {
      // Read database
      DocumentReference ref = _usersRef.doc(uid);
      await ref.delete();
    } on FirebaseException catch (error) {
      showErrorDialog(context, error.message!);
    }
  }
}
