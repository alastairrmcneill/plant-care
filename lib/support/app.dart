import 'package:flutter/material.dart';
import 'package:plant_care/features/onboarding/screens/screens.dart';
import 'package:plant_care/general/notifiers/notifiers.dart';
import 'package:plant_care/support/theme.dart';
import 'package:plant_care/support/wrapper.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  final bool showHome;
  const App({Key? key, required this.showHome}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SettingsNotifier settingsNotifier = Provider.of<SettingsNotifier>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Plant Care',
      theme: (settingsNotifier.darkMode) ? MyThemes.darkTheme : MyThemes.lightTheme,
      home: showHome ? const Wrapper() : const OnboardingScreen(),
    );
  }
}
