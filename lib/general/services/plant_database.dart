import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:plant_care/general/models/models.dart';
import 'package:plant_care/general/notifiers/notifiers.dart';
import 'package:plant_care/general/widgets/widgets.dart';
import 'package:provider/provider.dart';

class PlantDatabase {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;
  // static final CollectionReference _plantRef = _db.collection('plants');

  static create(BuildContext context, {required String householdID, required Plant plant}) async {
    try {
      DocumentReference _ref = _db.collection('households').doc(householdID).collection('plants').doc();

      Plant newPlant = plant.copy(uid: _ref.id);

      _ref.set(newPlant.toJson());
    } on FirebaseException catch (error) {
      showErrorDialog(context, error.message!);
    }
  }

  static Future<void> readMyPlants(BuildContext context) async {
    final String userId = Provider.of<User?>(context, listen: false)!.uid;
    PlantNotifier plantNotifier = Provider.of<PlantNotifier>(context, listen: false);

    List<Plant> _plantList = [];

    try {
      // // Find all events
      // QuerySnapshot snapshot = await _householdRef.where(HouseholdFields.members, arrayContains: userId).get();

      // for (var doc in snapshot.docs) {
      //   Household household = Household.fromJson(doc.data());
      //   _plantList.add(household);
      // }

      plantNotifier.setMyPlants = _plantList;
    } on FirebaseException catch (error) {
      showErrorDialog(context, error.message!);
    }
  }
}
