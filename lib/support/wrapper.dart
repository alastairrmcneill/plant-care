import 'package:flutter/material.dart';
import 'package:plant_care/models/models.dart';
import 'package:plant_care/screens/screens.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AppUser?>(context);
    if (user == null) {
      return WelcomeScreen();
    } else {
      return HomeScreen();
    }
  }
}
