import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:plant_care/general/models/models.dart';
import 'package:plant_care/general/notifiers/notifiers.dart';
import 'package:plant_care/general/services/household_database.dart';
import 'package:plant_care/general/widgets/widgets.dart';
import 'package:provider/provider.dart';

class PlantDatabase {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;
  // static final CollectionReference _plantRef = _db.collection('plants');

  static Future<String?> create(BuildContext context, {required String householdID, required Plant plant}) async {
    try {
      DocumentReference _ref = _db.collection('households').doc(householdID).collection('plants').doc();

      Plant newPlant = plant.copy(uid: _ref.id);

      _ref.set(newPlant.toJson());
      return newPlant.uid!;
    } on FirebaseException catch (error) {
      showErrorDialog(context, error.message!);
    }
  }

  static Future<void> readMyPlants(BuildContext context) async {
    final String userId = Provider.of<User?>(context, listen: false)!.uid;
    PlantNotifier plantNotifier = Provider.of<PlantNotifier>(context, listen: false);

    List<Plant> _plantList = [];

    try {
      // Find all households that we are a part of
      QuerySnapshot householdSnapshot = await _db.collection('households').where(HouseholdFields.members, arrayContains: userId).get();

      for (var household in householdSnapshot.docs) {
        // Find all the plants in that household
        QuerySnapshot plantSnapshot = await _db.collection('households').doc(household.id).collection('plants').get();
        for (var doc in plantSnapshot.docs) {
          Plant plant = Plant.fromJson(doc.data());
          _plantList.add(plant);
        }
      }

      plantNotifier.setMyPlants = _plantList;
    } on FirebaseException catch (error) {
      showErrorDialog(context, error.message!);
    }
  }
}
