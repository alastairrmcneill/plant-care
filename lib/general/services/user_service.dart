import 'package:flutter/material.dart';
import 'package:plant_care/general/models/models.dart';
import 'package:plant_care/general/services/services.dart';
import 'package:plant_care/general/widgets/widgets.dart';

class UserService {
  static Future updateUserName(BuildContext context, AppUser newUser) async {
    await UserDatabase.updateUser(context, newUser);
    showSnackBar(context, 'Name updated');

    await UserDatabase.readCurrentUser(context);
  }

  static Future updateUserPassword() async {}
}
