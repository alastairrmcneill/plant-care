import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsNotifier extends ChangeNotifier {
  late SharedPreferences prefs;
  late bool _darkMode;

  SettingsNotifier({required bool darkMode}) {
    _darkMode = darkMode;
  }

  bool get darkMode => _darkMode;

  Future<void> setDarkMode(bool darkMode) async {
    prefs = await SharedPreferences.getInstance();
    await prefs.setBool('darkMode', darkMode);
    _darkMode = darkMode;
    notifyListeners();
  }
}
