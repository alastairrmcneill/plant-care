import 'dart:math';

import 'package:flutter/material.dart';
import 'package:plant_care/general/models/models.dart';
import 'package:plant_care/general/notifiers/notifiers.dart';
import 'package:plant_care/general/services/services.dart';
import 'package:plant_care/general/widgets/widgets.dart';
import 'package:provider/provider.dart';

class HouseholdService {
  static Future create(BuildContext context, {required String name}) async {
    UserNotifier userNotifier = Provider.of<UserNotifier>(context, listen: false);
    String userId = userNotifier.currentUser!.uid!;

    // Get unique household code
    String code = _randomString(8);
    // TODO: check if household exists with this string. If it does then repeat.

    Household household = Household(name: name, code: code, members: [userId], plantsInfo: {});

    await HouseholdDatabase.create(context, household: household);
  }

  static Future add(BuildContext context, {required String code}) async {
    // Get current User ID
    UserNotifier userNotifier = Provider.of<UserNotifier>(context, listen: false);
    String userId = userNotifier.currentUser!.uid!;

    // // Get household or cancel if it doesn't exist
    Household? household = await HouseholdDatabase.getHouseholdFromCode(context, code: code);
    if (household == null) {
      // household doesn't exist.
      showErrorDialog(context, 'Household doesn\'t exist');
      return;
    }

    // Update household
    household.members.add(userId);
    await HouseholdDatabase.updateHousehold(context, household: household);

    await HouseholdDatabase.readMyHouseholds(context);
    await EventDatabase.readMyEvents(context);
  }

  static String _randomString(int length) {
    const ch = 'AaBbCcDdEeFfGgHhJjKkMmNnOoPpQqRrSsTtUuVvWwXxYyZz';
    Random r = Random();
    return String.fromCharCodes(Iterable.generate(length, (_) => ch.codeUnitAt(r.nextInt(ch.length))));
  }
}
