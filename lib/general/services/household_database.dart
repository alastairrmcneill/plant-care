import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:plant_care/general/models/models.dart';
import 'package:plant_care/general/notifiers/notifiers.dart';
import 'package:plant_care/general/services/services.dart';
import 'package:plant_care/general/widgets/widgets.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class HouseholdDatabase {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;
  static final CollectionReference _householdRef = _db.collection('households');

  static create(BuildContext context, {required Household household}) async {
    try {
      DocumentReference ref = _householdRef.doc();

      Household newHousehold = household.copy(uid: ref.id);

      await ref.set(newHousehold.toJson());
    } on FirebaseException catch (error) {
      showErrorDialog(context, error.message!);
    }
  }

  static Future readAllHouseholds(BuildContext context) async {
    HouseholdNotifier householdNotifier = Provider.of<HouseholdNotifier>(context, listen: false);

    List<Household> _householdList = [];

    try {
      // Find all events
      QuerySnapshot snapshot = await _householdRef.get();

      for (var doc in snapshot.docs) {
        Household household = Household.fromJson(doc.data());
        _householdList.add(household);
      }

      householdNotifier.setAllHouseholds = _householdList;
    } on FirebaseException catch (error) {
      showErrorDialog(context, error.message!);
    }
  }

  static Future<Household?> getHouseholdFromCode(BuildContext context, {required String code}) async {
    Household? household;
    try {
      Query query = _db.collection('households').where(HouseholdFields.code, isEqualTo: code);
      QuerySnapshot querySnapshot = await query.get();
      if (querySnapshot.docs.isEmpty) return household;

      household = Household.fromJson(querySnapshot.docs[0].data());
      return household;
    } on FirebaseException catch (error) {
      showErrorDialog(context, error.message!);
      return household;
    }
  }
}
