import 'package:flutter/material.dart';
import 'package:plant_care/general/models/models.dart';

class HouseholdNotifier extends ChangeNotifier {
  List<Household>? _myHouseholds;
  Household? _currentHousehold;
  Map<String, AppUser> _myHouseholdsMembers = {};

  List<Household>? get myHouseholds => _myHouseholds;
  Household? get currentHousehold => _currentHousehold;
  Map<String, AppUser> get myHouseholdsMembers => _myHouseholdsMembers;

  set setMyHouseholds(List<Household> myHouseholds) {
    _myHouseholds = myHouseholds;
    notifyListeners();
  }

  set setCurrentHousehold(Household currentHousehold) {
    _currentHousehold = currentHousehold;
    notifyListeners();
  }

  set addHouseholdMember(AppUser householdMember) {
    _myHouseholdsMembers[householdMember.uid!] = householdMember;
    notifyListeners();
  }
}
