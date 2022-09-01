import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:plant_care/general/models/models.dart';
import 'package:plant_care/general/widgets/widgets.dart';

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
}
