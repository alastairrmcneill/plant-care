import 'dart:math';

import 'package:flutter/material.dart';
import 'package:plant_care/general/models/models.dart';
import 'package:plant_care/general/notifiers/notifiers.dart';
import 'package:plant_care/general/services/services.dart';
import 'package:provider/provider.dart';

class HouseholdService {
  static Future create(BuildContext context, {required String name}) async {
    UserNotifier userNotifier = Provider.of<UserNotifier>(context, listen: false);
    String userId = userNotifier.currentUser!.uid!;

    // Get unique household code
    String code = _randomString(8);
    // TODO: check if household exists with this string. If it does then repeat.

    Household household = Household(name: name, code: code, members: [userId]);

    await HouseholdDatabase.create(context, household: household);
  }

  static Future add(BuildContext context, {required String code}) async {
    // Get current User ID
    UserNotifier userNotifier = Provider.of<UserNotifier>(context, listen: false);
    String userId = userNotifier.currentUser!.uid!;

    // // Get household
    // TODO: check it exists, if it doesn't then exit with message, if it does then carry on
    // Household household = await HouseholdDatabaseService.getHouseholdFromCode(code);

    // // Update user
    // AppUser user = await UserDatabaseService.getUser(userID: userID);
    // user.households.add(household.uid!);
    // await UserDatabaseService.updateUser(userNotifier, user);

    // // Update household
    // household.members.add(userID);
    // household.memberCount++;
    // await HouseholdDatabaseService.updateHousehold(householdNotifier, household);

    // return household.name;
  }

  static String _randomString(int length) {
    const ch = 'AaBbCcDdEeFfGgHhJjKkMmNnOoPpQqRrSsTtUuVvWwXxYyZz';
    Random r = Random();
    return String.fromCharCodes(Iterable.generate(length, (_) => ch.codeUnitAt(r.nextInt(ch.length))));
  }
}
