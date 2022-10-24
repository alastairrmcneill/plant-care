// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:plant_care/general/models/event_model.dart';
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
    required String wateringNotes,
    required List<bool> mistingDays,
    required String mistingRecurrence,
    required String mistingNotes,
    required List<bool> feedingDays,
    required String feedingRecurrence,
    required String feedingNotes,
  }) async {
    showCircularProgressOverlay(context);
    // Upload image
    String? photoURL;
    if (image != null) {
      photoURL = await StorageService.uploadPlantImage(image);
    }

    // Create plant
    // Watering
    Map<String, Object?> wateringDetails = {
      PlantFields.days: wateringDays,
      PlantFields.recurrence: wateringRecurrence,
      PlantFields.notes: wateringNotes,
    };

    // Misting

    Map<String, Object?> mistingDetails = {
      PlantFields.days: mistingDays,
      PlantFields.recurrence: mistingRecurrence,
      PlantFields.notes: mistingNotes,
    };

    // Feeding

    Map<String, Object?> feedingDetails = {
      PlantFields.days: feedingDays,
      PlantFields.recurrence: feedingRecurrence,
      PlantFields.notes: feedingNotes,
    };

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
      type: EventTypes.water,
      subject: '$name - water',
    );

    if (mistingDays.contains(true)) {
      await EventService.create(
        context,
        plantUid: plant.uid,
        days: mistingDays,
        recurrence: mistingRecurrence,
        notes: mistingNotes,
        type: EventTypes.mist,
        subject: '$name - mist',
      );
    }

    if (feedingDays.contains(true)) {
      await EventService.create(
        context,
        plantUid: plant.uid,
        days: feedingDays,
        recurrence: feedingRecurrence,
        notes: feedingNotes,
        type: EventTypes.feed,
        subject: '$name - feed',
      );
    }

    // Update notifiers
    await EventDatabase.readMyEvents(context);
    await HouseholdDatabase.readMyHouseholds(context);

    stopCircularProgressOverlay(context);
    Navigator.of(context).pop();
  }

  static Future updatePlant(
    BuildContext context, {
    required Plant originalPlant,
    required String name,
    required List<bool> wateringDays,
    required String wateringRecurrence,
    required String wateringNotes,
    required List<bool> mistingDays,
    required String mistingRecurrence,
    required String mistingNotes,
    required List<bool> feedingDays,
    required String feedingRecurrence,
    required String feedingNotes,
  }) async {
    showCircularProgressOverlay(context);
    // Delete existing events for this plant
    await EventDatabase.deletePlantEvents(context, plantUid: originalPlant.uid);

    // Creat new plant
    int daysUntil = 0;
    DateTime now = DateTime.now();

    int dayOfWeek = now.weekday - 1;
    int result = wateringDays.indexOf(true, dayOfWeek);

    if (result == -1) {
      // next day is next week
      int daysUntilNextWeek = 6 - dayOfWeek;
      int dayNextWeek = wateringDays.indexOf(true);
      daysUntil = daysUntilNextWeek + dayNextWeek + 1;
    } else {
      daysUntil = result - dayOfWeek;
    }

    Map<String, Object?> wateringDetails = {
      PlantFields.days: wateringDays,
      PlantFields.recurrence: wateringRecurrence,
      PlantFields.notes: wateringNotes,
      "nextAction": now.add(Duration(days: daysUntil))
    };
    Map<String, Object?> mistingDetails = {
      PlantFields.days: mistingDays,
      PlantFields.recurrence: mistingRecurrence,
      PlantFields.notes: mistingNotes,
    };
    Map<String, Object?> feedingDetails = {
      PlantFields.days: feedingDays,
      PlantFields.recurrence: feedingRecurrence,
      PlantFields.notes: feedingNotes,
    };

    Plant newPlant = originalPlant.copy(
      name: name,
      wateringDetails: wateringDetails,
      mistingDetails: mistingDetails,
      feedingDetails: feedingDetails,
    );

    // Update household with new plant data
    await HouseholdDatabase.updatePlant(context, householdUid: originalPlant.householdUid, plant: newPlant);

    // Create Events
    await EventService.create(
      context,
      plantUid: originalPlant.uid,
      days: wateringDays,
      recurrence: wateringRecurrence,
      notes: wateringNotes,
      type: EventTypes.water,
      subject: '${newPlant.name} - water',
    );

    if (mistingDays.contains(true)) {
      await EventService.create(
        context,
        plantUid: originalPlant.uid,
        days: mistingDays,
        recurrence: mistingRecurrence,
        notes: mistingNotes,
        type: EventTypes.mist,
        subject: '${newPlant.name} - misting',
      );
    }

    if (feedingDays.contains(true)) {
      await EventService.create(
        context,
        plantUid: originalPlant.uid,
        days: feedingDays,
        recurrence: feedingRecurrence,
        notes: feedingNotes,
        type: EventTypes.feed,
        subject: '${newPlant.name} - feeding',
      );
    }

    // Update notifiers
    await EventDatabase.readMyEvents(context);
    await HouseholdDatabase.readMyHouseholds(context);
    PlantNotifier plantNotifier = Provider.of<PlantNotifier>(context, listen: false);
    plantNotifier.setCurrentPlant = newPlant;

    stopCircularProgressOverlay(context);
    Navigator.of(context).pop();
  }

  static Future removePlantFromHousehold(BuildContext context, {required Plant plant}) async {
    showTwoButtonDialog(
      context,
      'Are you sure you want to delete your ${plant.name}?',
      'Yes',
      () async {
        showCircularProgressOverlay(context);

        await HouseholdDatabase.removePlant(context, householdUid: plant.householdUid, plantUid: plant.uid);
        await EventDatabase.deletePlantEvents(context, plantUid: plant.uid);
        await HouseholdDatabase.readMyHouseholds(context);
        await EventDatabase.readMyEvents(context);
        stopCircularProgressOverlay(context);
        Navigator.of(context).pop();
      },
      'Cancel',
      () {},
    );
  }
}
