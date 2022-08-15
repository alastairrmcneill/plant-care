import 'package:flutter/material.dart';
import 'package:plant_care/auth/screens/screens.dart';
import 'package:plant_care/general/models/models.dart';
import 'package:plant_care/home/general/screens/screens.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AppUser?>(context);
    if (user == null) {
      return const LoginScreen();
    } else {
      return const HomeScreen();
    }
  }
}
