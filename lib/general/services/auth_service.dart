import 'package:firebase_auth/firebase_auth.dart';
import 'package:plant_care/general/models/models.dart';

class AuthService {
  static FirebaseAuth _auth = FirebaseAuth.instance;

  // Auth user stream
  Stream<AppUser?> get appUserStream {
    return _auth.authStateChanges().map((User? user) => _appUserFromFirebaseUser(user));
  }

  // Create account

  // Login to account

  // Forgot password to account

  // Sign out of account

  // Delete Account

  // AppUser from Firebase user
  AppUser? _appUserFromFirebaseUser(User? user) {
    return (user != null) ? AppUser(uid: user.uid) : null;
  }
}
