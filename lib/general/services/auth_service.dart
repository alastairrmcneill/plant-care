// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:plant_care/general/models/models.dart';
import 'package:plant_care/general/services/services.dart';
import 'package:plant_care/general/widgets/widgets.dart';
import 'package:plant_care/support/wrapper.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class AuthService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  static final GoogleSignIn _googleSignIn = GoogleSignIn();

  // Auth user stream
  static Stream<User?> get appUserStream {
    return _auth.authStateChanges();
  }

  // Register
  static Future registerWithEmail(BuildContext context, {required String email, required String password, required String name, required File? image}) async {
    String initials = '';
    List<String> names = name.split(' ');
    if (names.length == 0) {
      initials = names.first[0].toUpperCase();
    } else {
      initials = names.first[0].toUpperCase() + names.last[0].toUpperCase();
    }

    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      if (user != null) {
        String? token = await _messaging.getToken();
        AppUser appUser = AppUser(
          uid: user.uid,
          name: name,
          email: email,
          photoUrl: null,
          initials: initials,
          token: token!,
        );

        // Add user to database
        await UserDatabase.createUser(
          context,
          appUser: appUser,
          image: image,
        );
      }
    } on FirebaseAuthException catch (error) {
      showErrorDialog(context, error.message!);
      return;
    } on FirebaseException catch (error) {
      showErrorDialog(context, error.message!);
      return;
    }
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Wrapper()), (_) => false);
  }

  // Login with google
  static Future loginWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) return;

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      String initials = '';
      List<String> names = googleUser.displayName!.split(' ');
      if (names.length == 0) {
        initials = names.first[0].toUpperCase();
      } else {
        initials = names.first[0].toUpperCase() + names.last[0].toUpperCase();
      }

      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential result = await _auth.signInWithCredential(credential);

      User? user = result.user;
      if (user != null) {
        String? token = await _messaging.getToken();
        AppUser appUser = AppUser(
          uid: user.uid,
          name: user.displayName!,
          email: user.email!,
          photoUrl: user.photoURL,
          initials: initials,
          token: token!,
        );
        // Add user to database
        await UserDatabase.updateUser(context, appUser);
        await HouseholdDatabase.setToken(context, userUid: appUser.uid!, token: token);
      }
    } on FirebaseAuthException catch (error) {
      showErrorDialog(context, error.message!);
    }
  }

  // Apple sign in
  static Future signInWithApple(BuildContext context) async {
    try {
      final appleIdCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );
      final OAuthProvider oAuthProvider = OAuthProvider('apple.com');
      OAuthCredential credential = oAuthProvider.credential(
        idToken: appleIdCredential.identityToken,
        accessToken: appleIdCredential.authorizationCode,
      );

      UserCredential result = await _auth.signInWithCredential(credential);

      if (result.user!.displayName == null) {
        await result.user!
            .updateDisplayName(
              "${appleIdCredential.givenName ?? ""} ${appleIdCredential.familyName ?? ""}",
            )
            .whenComplete(
              () => result.user!.reload(),
            );
      }

      String initials = '';
      List<String> names = result.user!.displayName!.split(' ');

      if (names.isEmpty) {
        initials = names.first[0].toUpperCase();
      } else {
        initials = names.first[0].toUpperCase() + names.last[0].toUpperCase();
      }

      User? user = result.user;
      if (user != null) {
        String? token = await _messaging.getToken();
        AppUser appUser = AppUser(
          uid: user.uid,
          name: user.displayName!,
          email: user.email!,
          photoUrl: user.photoURL,
          initials: initials,
          token: token!,
        );
        // Add user to database
        await UserDatabase.updateUser(context, appUser);
        await HouseholdDatabase.setToken(context, userUid: appUser.uid!, token: token);
      }
    } on FirebaseAuthException catch (error) {
      showErrorDialog(context, error.message!);
    }
  }

  static Future loginWithEmail(BuildContext context, {required String email, required String password}) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      await setToken(context);
    } on FirebaseAuthException catch (error) {
      showErrorDialog(context, error.message!);
    }
  }

  // Forgot password to account
  static Future forgotPassword(BuildContext context, {required String email}) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      showSnackBar(context, 'Password retreival email sent');
    } on FirebaseAuthException catch (error) {
      showErrorDialog(context, error.message!);
    }
  }

  // Sign out of account
  static Future<void> signOut(BuildContext context) async {
    await removeToken(context);
    if (_googleSignIn.currentUser != null) {
      await _googleSignIn.disconnect();
    }
    await _auth.signOut();
  }

  // Delete Account
  static Future delete(BuildContext context) async {
    try {
      await UserDatabase.deleteUser(context, uid: _auth.currentUser!.uid);
      await _auth.currentUser!.delete();

      showSnackBar(context, 'User deleted');
    } on FirebaseAuthException catch (error) {
      showErrorDialog(context, error.message!);
    }
  }

  static Future<void> removeToken(BuildContext context) async {
    final currentUser = _auth.currentUser;

    await UserDatabase.removeToken(context, uid: currentUser!.uid);
    await HouseholdDatabase.removeToken(context, userUid: currentUser.uid);
  }

  static Future<void> setToken(BuildContext context) async {
    final currentUser = _auth.currentUser;

    String? token = await _messaging.getToken();

    await UserDatabase.setToken(context, uid: currentUser!.uid, token: token!);
    await HouseholdDatabase.setToken(context, userUid: currentUser.uid, token: token);
  }
}
