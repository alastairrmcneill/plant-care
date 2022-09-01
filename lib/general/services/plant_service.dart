// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:plant_care/general/models/models.dart';
import 'package:plant_care/general/services/services.dart';
import 'package:flutter/material.dart';
import 'package:plant_care/general/widgets/widgets.dart';

class PlantService {
  static Future create(
    BuildContext context, {
    required Household household,
    required String name,
    required File? image,
    required List<bool> wateringDays,
    required String wateringRecurrence,
    required String? wateringNotes,
    required List<bool> mistingDays,
    required String mistingRecurrence,
    required String? mistingNotes,
    required List<bool> feedingDays,
    required String feedingRecurrence,
    required String? feedingNotes,
  }) async {
    showCircularProgressOverlay(context);
    // Upload image
    String? photoURL;
    if (image != null) {
      photoURL = await StorageService.uploadPlantImage(image);
    }

    // Create plant
    Plant plant = Plant(name: name, photoURL: photoURL);

    //TODO: include rough event details in plant to make it easier to view when not in the calendar

    // Upload plant
    await PlantDatabase.create(context, householdID: household.uid!, plant: plant);

    // Create Events
    await EventService.create(
      context,
      days: wateringDays,
      recurrence: wateringRecurrence,
      notes: wateringNotes,
      type: 'water',
      subject: '$name - water',
    );

    if (mistingDays.contains(true)) {
      await EventService.create(
        context,
        days: mistingDays,
        recurrence: mistingRecurrence,
        notes: mistingNotes,
        type: 'misting',
        subject: '$name - misting',
      );
    }

    if (feedingDays.contains(true)) {
      await EventService.create(
        context,
        days: feedingDays,
        recurrence: feedingRecurrence,
        notes: feedingNotes,
        type: 'feeding',
        subject: '$name - feeding',
      );
    }

    // Update notifiers
    EventDatabase.readAllEvents(context);

    stopCircularProgressOverlay(context);
    Navigator.of(context).pop();
  }
}
