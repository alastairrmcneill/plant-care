import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

  static Future readMyHouseholds(BuildContext context) async {
    final String userId = Provider.of<User?>(context, listen: false)!.uid;
    HouseholdNotifier householdNotifier = Provider.of<HouseholdNotifier>(context, listen: false);
    PlantNotifier plantNotifier = Provider.of<PlantNotifier>(context, listen: false);
    List<Household> _householdList = [];
    List<Plant> _plantList = [];

    try {
      // Find all households
      QuerySnapshot snapshot = await _householdRef
          .where(
            HouseholdFields.members,
            arrayContains: userId,
          )
          .orderBy(
            HouseholdFields.name,
            descending: false,
          )
          .get();

      for (var doc in snapshot.docs) {
        // Add households
        Household household = Household.fromJson(doc.data());
        _householdList.add(household);

        // add all plants
        if (household.plantsInfo.isNotEmpty) {
          household.plantsInfo.forEach((key, value) {
            Plant plant = Plant.fromJson(value);
            _plantList.add(plant);
          });
        }

        // Add all members
        for (var uid in household.members) {
          AppUser? appUser = await UserDatabase.readUser(context, uid: uid);
          if (appUser != null) {
            householdNotifier.addHouseholdMember = appUser;
          }
        }
      }

      householdNotifier.setMyHouseholds = _householdList;
      plantNotifier.setMyPlants = _plantList;
    } on FirebaseException catch (error) {
      showErrorDialog(context, error.message!);
    }
  }

  static Future updateHousehold(BuildContext context, {required Household household}) async {
    try {
      DocumentReference ref = _householdRef.doc(household.uid);

      await ref.update(household.toJson());
    } on FirebaseException catch (error) {
      showErrorDialog(context, error.message!);
    }
  }

  static Future removeUserFromHousehold(BuildContext context, {required Household household, required String userUid}) async {
    try {
      DocumentReference ref = _householdRef.doc(household.uid);
      await ref.update({
        HouseholdFields.members: FieldValue.arrayRemove([userUid]),
        '${HouseholdFields.memberInfo}.$userUid': {},
      });
    } on FirebaseException catch (error) {
      showErrorDialog(context, error.message!);
    }
  }

  static Future removePlant(BuildContext context, {required String householdUid, required String plantUid}) async {
    try {
      DocumentReference ref = _householdRef.doc(householdUid);

      DocumentSnapshot snapshot = await ref.get();

      if (snapshot.exists) {
        Household household = Household.fromJson(snapshot.data());
        household.plantsInfo.remove(plantUid);
        household.plants.remove(plantUid);
        await HouseholdDatabase.updateHousehold(context, household: household);
      }
    } on FirebaseException catch (error) {
      showErrorDialog(context, error.message!);
    }
  }

  static Future removeToken(BuildContext context, {required String userUid}) async {
    QuerySnapshot querySnapshot = await _householdRef.where('members', arrayContains: userUid).get();

    for (var doc in querySnapshot.docs) {
      await doc.reference.update({
        '${HouseholdFields.memberInfo}.$userUid.token': '',
      });
    }
  }

  static Future setToken(BuildContext context, {required String userUid, required String token}) async {
    QuerySnapshot querySnapshot = await _householdRef.where('members', arrayContains: userUid).get();

    for (var doc in querySnapshot.docs) {
      await doc.reference.update({
        '${HouseholdFields.memberInfo}.$userUid.token': token,
      });
    }
  }

  static Future updatePlant(BuildContext context, {required String householdUid, required Plant plant}) async {
    try {
      DocumentReference ref = _householdRef.doc(householdUid);

      await ref.update({'${HouseholdFields.plantsInfo}.${plant.uid}': plant.toJson()});
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
