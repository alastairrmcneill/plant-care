// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:plant_care/general/models/models.dart';
import 'package:plant_care/general/notifiers/notifiers.dart';
import 'package:plant_care/general/services/services.dart';
import 'package:flutter/material.dart';
import 'package:plant_care/general/widgets/widgets.dart';
import 'package:provider/provider.dart';

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
    Map<String, Object?> wateringDetails = {'wateringDays': wateringDays, 'wateringRecurrence': wateringRecurrence, 'wateringNotes': wateringNotes};
    Map<String, Object?> mistingDetails = {'mistingDays': mistingDays, 'mistingRecurrence': mistingRecurrence, 'mistingNotes': mistingNotes};
    Map<String, Object?> feedingDetails = {'feedingDays': feedingDays, 'feedingRecurrence': feedingRecurrence, 'feedingNotes': feedingNotes};

    Plant plant = Plant(
      name: name,
      photoURL: photoURL,
      wateringDetails: wateringDetails,
      mistingDetails: mistingDetails,
      feedingDetails: feedingDetails,
    );

    // Upload plant
    String? plantUid = await PlantDatabase.create(context, householdID: household.uid!, plant: plant);
    if (plantUid == null) return;

    // Create Events
    await EventService.create(
      context,
      plantUid: plantUid,
      days: wateringDays,
      recurrence: wateringRecurrence,
      notes: wateringNotes,
      type: 'water',
      subject: '$name - water',
    );

    if (mistingDays.contains(true)) {
      await EventService.create(
        context,
        plantUid: plantUid,
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
        plantUid: plantUid,
        days: feedingDays,
        recurrence: feedingRecurrence,
        notes: feedingNotes,
        type: 'feeding',
        subject: '$name - feeding',
      );
    }

    // Update user
    AppUser user = Provider.of<UserNotifier>(context, listen: false).currentUser!;
    user.plantUids.add(plantUid);
    UserDatabase.updateUser(context, user);

    // Update notifiers
    EventDatabase.readMyEvents(context);
    HouseholdDatabase.readMyHouseholds(context);
    PlantDatabase.readMyPlants(context);

    stopCircularProgressOverlay(context);
    Navigator.of(context).pop();
  }
}
