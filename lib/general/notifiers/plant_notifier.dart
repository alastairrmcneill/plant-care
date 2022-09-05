import 'package:flutter/material.dart';
import 'package:plant_care/general/models/models.dart';

class PlantNotifier extends ChangeNotifier {
  List<Plant>? _myPlants;
  Plant? _currentPlant;

  List<Plant>? get myPlants => _myPlants;
  Plant? get currentPlant => _currentPlant;

  set setMyPlants(List<Plant> myPlants) {
    _myPlants = myPlants;
    notifyListeners();
  }

  set setCurrentPlant(Plant currentPlant) {
    _currentPlant = currentPlant;
    notifyListeners();
  }
}
