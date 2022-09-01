import 'dart:io';

import 'package:plant_care/general/models/models.dart';
import 'package:plant_care/general/services/plant_database.dart';
import 'package:plant_care/general/services/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:plant_care/general/widgets/widgets.dart';

class PlantService {
  static Future create(BuildContext context, {required String name, required File? image}) async {
    showCircularProgressOverlay(context);
    // Upload image
    String? photoURL;
    if (image != null) {
      photoURL = await StorageService.uploadPlantImage(image);
    }

    // Create plant
    Plant plant = Plant(name: name, photoURL: photoURL);

    // Upload plant
    PlantDatabase.create(context, plant: plant);

    // Create Events

    // Upload events

    stopCircularProgressOverlay(context);
  }
}
