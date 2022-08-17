import 'package:flutter/material.dart';
import 'package:plant_care/features/auth/screens/screens.dart';
import 'package:plant_care/general/models/models.dart';
import 'package:plant_care/features/home/general/screens/screens.dart';
import 'package:plant_care/general/notifiers/notifiers.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AppUser?>(context);
    final UserNotifier userNotifier = Provider.of<UserNotifier>(context, listen: false);
    if (user == null) {
      return LoginScreen();
    } else {
      userNotifier.setWithoutNotifyCurrentUserId = user.uid!;
      userNotifier.setWithoutNotifyCurrentUser = user;
      return const HomeScreen();
    }
  }
}
