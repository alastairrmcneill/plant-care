import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:plant_care/features/onboarding/screens/screens.dart';
import 'package:plant_care/general/notifiers/notifiers.dart';
import 'package:plant_care/support/theme.dart';
import 'package:plant_care/support/wrapper.dart';
import 'package:provider/provider.dart';
import 'general/services/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  final prefs = await SharedPreferences.getInstance();
  final bool showHome = prefs.getBool('showHome') ?? false;
  runApp(MyApp(prefs: prefs, showHome: showHome));
}

class MyApp extends StatelessWidget {
  final SharedPreferences prefs;
  final bool showHome;
  MyApp({Key? key, required this.prefs, required this.showHome}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<User?>.value(
          value: AuthService.appUserStream,
          initialData: null,
        ),
        ChangeNotifierProvider<UserNotifier>(
          create: (_) => UserNotifier(),
        ),
        ChangeNotifierProvider<SettingsNotifier>(
          create: (_) => SettingsNotifier(
            darkMode: prefs.getBool('darkMode') ?? false,
          ),
        ),
        ChangeNotifierProvider<EventNotifier>(
          create: (_) => EventNotifier(),
        ),
        ChangeNotifierProvider<HouseholdNotifier>(
          create: (_) => HouseholdNotifier(),
        ),
        ChangeNotifierProvider<PlantNotifier>(
          create: (_) => PlantNotifier(),
        ),
      ],
      child: MaterialApp(
        title: 'Plant Care',
        debugShowCheckedModeBanner: false,
        theme: MyThemes.lightTheme,
        home: showHome ? const Wrapper() : const OnboardingScreen(),
      ),
    );
  }
}
