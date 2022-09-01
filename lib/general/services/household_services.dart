import 'package:flutter/material.dart';
import 'package:plant_care/general/models/models.dart';
import 'package:plant_care/general/services/services.dart';

class HouseholdService {
  static Future create(BuildContext context, {required String name}) async {
    Household household = Household(name: name);

    await HouseholdDatabase.create(context, household: household);
  }
}
