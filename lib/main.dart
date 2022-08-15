import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:plant_care/general/models/models.dart';
import 'package:plant_care/general/notifiers/notifiers.dart';
import 'package:plant_care/support/theme.dart';
import 'package:plant_care/support/wrapper.dart';
import 'package:provider/provider.dart';
import 'general/services/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<AppUser?>.value(
          value: AuthService().appUserStream,
          initialData: null,
        ),
        ChangeNotifierProvider<UserNotifier>(
          create: (_) => UserNotifier(),
        ),
      ],
      child: MaterialApp(
        title: 'Plant Care',
        debugShowCheckedModeBanner: false,
        theme: MyThemes.lightTheme,
        home: const Wrapper(),
      ),
    );
  }
}
