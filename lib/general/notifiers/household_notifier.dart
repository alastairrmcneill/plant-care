import 'package:flutter/material.dart';
import 'package:plant_care/general/models/models.dart';

class HouseholdNotifier extends ChangeNotifier {
  List<Household>? _myHouseholds;

  List<Household>? get myHouseholds => _myHouseholds;

  set setMyHouseholds(List<Household> myHouseholds) {
    _myHouseholds = myHouseholds;
    notifyListeners();
  }
}
