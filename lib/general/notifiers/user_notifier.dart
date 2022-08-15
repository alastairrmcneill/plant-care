import 'package:flutter/material.dart';
import 'package:plant_care/general/models/models.dart';

class UserNotifier extends ChangeNotifier {
  String? _currentUserId;
  AppUser? _currentUser;

  String? get currentUserId => _currentUserId;
  AppUser? get currentUser => _currentUser;

  set setCurrentUserId(String currentUserId) {
    _currentUserId = currentUserId;
    notifyListeners();
  }

  set setCurrentUser(AppUser currentUser) {
    _currentUser = currentUser;
    notifyListeners();
  }
}
