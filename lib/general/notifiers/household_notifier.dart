import 'package:flutter/material.dart';
import 'package:plant_care/general/models/models.dart';

class HouseholdNotifier extends ChangeNotifier {
  List<Household> _allHouseholds = [];

  List<Household> get allHouseholds => _allHouseholds;

  set setAllHouseholds(List<Household> allHouseholds) {
    _allHouseholds = allHouseholds;
    notifyListeners();
  }
}
