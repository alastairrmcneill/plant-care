// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:plant_care/general/models/models.dart';
import 'package:plant_care/general/notifiers/notifiers.dart';
import 'package:plant_care/general/services/services.dart';
import 'package:flutter/material.dart';
import 'package:plant_care/general/widgets/widgets.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

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
      uid: Uuid().v4(),
      householdUid: household.uid!,
      name: name,
      photoURL: photoURL,
      wateringDetails: wateringDetails,
      mistingDetails: mistingDetails,
      feedingDetails: feedingDetails,
    );

    // Update household
    household.plantsInfo[plant.uid] = plant.toJson();
    HouseholdDatabase.updateHousehold(context, household: household);

    // Create Events
    await EventService.create(
      context,
      plantUid: plant.uid,
      days: wateringDays,
      recurrence: wateringRecurrence,
      notes: wateringNotes,
      type: 'water',
      subject: '$name - water',
    );

    if (mistingDays.contains(true)) {
      await EventService.create(
        context,
        plantUid: plant.uid,
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
        plantUid: plant.uid,
        days: feedingDays,
        recurrence: feedingRecurrence,
        notes: feedingNotes,
        type: 'feeding',
        subject: '$name - feeding',
      );
    }

    // Update notifiers
    await EventDatabase.readMyEvents(context);
    await HouseholdDatabase.readMyHouseholds(context);

    stopCircularProgressOverlay(context);
    Navigator.of(context).pop();
  }

  static Future removePlantFromHousehold(BuildContext context, {required Plant plant}) async {
    showTwoButtonDialog(
      context,
      'Are you sure you want to delete your ${plant.name}?',
      'OK',
      () async {
        showCircularProgressOverlay(context);

        await HouseholdDatabase.removePlant(context, householdUid: plant.householdUid, plantUid: plant.uid);
        await HouseholdDatabase.readMyHouseholds(context);
        stopCircularProgressOverlay(context);
        Navigator.of(context).pop();
      },
      'Cancel',
      () {},
    );
  }
}
