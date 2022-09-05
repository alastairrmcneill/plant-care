import 'package:flutter/material.dart';
import 'package:plant_care/general/models/models.dart';

class HouseholdNotifier extends ChangeNotifier {
  List<Household>? _myHouseholds;
  Household? _currentHousehold;

  List<Household>? get myHouseholds => _myHouseholds;
  Household? get currentHousehold => _currentHousehold;

  set setMyHouseholds(List<Household> myHouseholds) {
    _myHouseholds = myHouseholds;
    notifyListeners();
  }

  set setCurrentHousehold(Household currentHousehold) {
    _currentHousehold = currentHousehold;
    notifyListeners();
  }
}
