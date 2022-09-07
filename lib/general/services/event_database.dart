import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:plant_care/general/models/models.dart';
import 'package:plant_care/general/notifiers/notifiers.dart';
import 'package:plant_care/general/widgets/widgets.dart';
import 'package:provider/provider.dart';

class EventDatabase {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;
  static final CollectionReference _eventRef = _db.collection('events');

  static create(BuildContext context, {required Event event}) async {
    try {
      DocumentReference ref = _eventRef.doc();

      Event newEvent = event.copy(uid: ref.id);

      ref.set(newEvent.toJson());
    } on FirebaseException catch (error) {
      showErrorDialog(context, error.message!);
    }
  }

  static Future readMyEvents(BuildContext context) async {
    EventNotifier eventNotifier = Provider.of<EventNotifier>(context, listen: false);
    List<Event> _eventList = [];
    List<String> _plantUids = [];

    // Get curent user
    UserNotifier userNotifier = Provider.of<UserNotifier>(context, listen: false);
    AppUser? user = userNotifier.currentUser;
    if (user == null) return;
    String userId = user.uid!;

    try {
      // Find all households that we are a part of
      QuerySnapshot householdSnapshot = await _db.collection('households').where(HouseholdFields.members, arrayContains: userId).get();

      for (var household in householdSnapshot.docs) {
        Household _household = Household.fromJson(household.data());

        if (_household.plantsInfo.isNotEmpty) {
          _household.plantsInfo.forEach((key, value) {
            _plantUids.add(key);
          });
        }
      }

      if (_plantUids.isEmpty) return;
      // Find all events
      QuerySnapshot snapshot = await _eventRef.where(EventFields.plantUid, whereIn: _plantUids).get();

      for (var doc in snapshot.docs) {
        Event event = Event.fromJson(doc.data());
        _eventList.add(event);
      }

      eventNotifier.setAllEvents = _eventList;
    } on FirebaseException catch (error) {
      showErrorDialog(context, error.message!);
    }
  }
}
