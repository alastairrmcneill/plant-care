import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:plant_care/features/onboarding/screens/screens.dart';
import 'package:plant_care/general/notifiers/notifiers.dart';
import 'package:plant_care/support/theme.dart';
import 'package:plant_care/support/wrapper.dart';
import 'package:provider/provider.dart';
import 'dart:io';

class App extends StatefulWidget {
  final bool showHome;
  const App({Key? key, required this.showHome}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();
    if (Platform.isIOS) {
      FirebaseMessaging.instance.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    SettingsNotifier settingsNotifier = Provider.of<SettingsNotifier>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Plant Care',
      theme: (settingsNotifier.darkMode) ? MyThemes.darkTheme : MyThemes.lightTheme,
      home: widget.showHome ? const Wrapper() : const OnboardingScreen(),
    );
  }
}
