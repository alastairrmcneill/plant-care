import 'package:flutter/material.dart';
import 'package:plant_care/general/models/models.dart';

class EventNotifier extends ChangeNotifier {
  static List<Event> _allEvents = [];
  static List<Event> _currentPlantEvents = [];
  static List<Event> _currentHouseholdEvents = [];

  List<Event> get allEvents => _allEvents;
  List<Event> get currentPlantEvents => _currentPlantEvents;
  List<Event> get currentHouseholdEvents => _currentHouseholdEvents;

  set setAllEvents(List<Event> allEvents) {
    _allEvents = allEvents;
    notifyListeners();
  }

  set setCurrentPlantEvents(List<Event> currentPlantEvents) {
    _currentPlantEvents = currentPlantEvents;
    notifyListeners();
  }

  set setCurrentHouseholdEvents(List<Event> currentHouseholdEvents) {
    _currentHouseholdEvents = currentHouseholdEvents;
    notifyListeners();
  }
}
