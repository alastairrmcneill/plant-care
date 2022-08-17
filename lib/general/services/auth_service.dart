import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:plant_care/general/models/models.dart';
import 'package:plant_care/general/widgets/widgets.dart';
import 'package:plant_care/support/wrapper.dart';

class AuthService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final GoogleSignIn _googleSignIn = GoogleSignIn();

  // Auth user stream
  Stream<AppUser?> get appUserStream {
    return _auth.authStateChanges().map((User? user) {
      print(user);
      return _appUserFromFirebaseUser(user);
    });
  }

  // Register
  static Future registerWithEmail(BuildContext context, {required String email, required String password}) async {
    showCircularProgressOverlay(context);

    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
      stopCircularProgressOverlay(context);
    } on FirebaseAuthException catch (error) {
      stopCircularProgressOverlay(context);
      showErrorDialog(context, error.message!);
      return;
    }
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Wrapper()), (_) => false);
  }

  // Login to account
  static Future loginWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) return;

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      showCircularProgressOverlay(context);
      await _auth.signInWithCredential(credential);
      stopCircularProgressOverlay(context);
    } on FirebaseAuthException catch (error) {
      stopCircularProgressOverlay(context);
      showErrorDialog(context, error.message!);
    }
  }

  static Future loginWithEmail(BuildContext context, {required String email, required String password}) async {
    showCircularProgressOverlay(context);
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      stopCircularProgressOverlay(context);
    } on FirebaseAuthException catch (error) {
      stopCircularProgressOverlay(context);
      showErrorDialog(context, error.message!);
    }
  }

  // Forgot password to account
  static Future forgotPassword(context, {required String email}) async {
    showCircularProgressOverlay(context);

    try {
      await _auth.sendPasswordResetEmail(email: email);
      showSnackBar(context, 'Password retreival email sent');
      stopCircularProgressOverlay(context);
    } on FirebaseAuthException catch (error) {
      stopCircularProgressOverlay(context);
      showErrorDialog(context, error.message!);
    }
  }

  // Sign out of account
  static Future signOut() async {
    if (_googleSignIn.currentUser != null) {
      await _googleSignIn.disconnect();
    }
    await _auth.signOut();
  }

  // Delete Account

  static Future delete(BuildContext context) async {
    showCircularProgressOverlay(context);
    try {
      await _auth.currentUser!.delete();
      stopCircularProgressOverlay(context);
      showSnackBar(context, 'User deleted');
    } on FirebaseAuthException catch (error) {
      stopCircularProgressOverlay(context);
      showErrorDialog(context, error.message!);
    }
  }

  // AppUser from Firebase user
  AppUser? _appUserFromFirebaseUser(User? user) {
    return (user != null) ? AppUser(uid: user.uid) : null;
  }
}
