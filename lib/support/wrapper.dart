import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:plant_care/features/auth/screens/screens.dart';
import 'package:plant_care/features/home/general/screens/screens.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);
    if (user == null) {
      return LoginScreen();
    } else {
      return const HomeScreen();
    }
  }
}
