import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:plant_care/general/models/models.dart';
import 'package:plant_care/general/notifiers/notifiers.dart';
import 'package:plant_care/general/services/services.dart';
import 'package:plant_care/general/widgets/widgets.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

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
    UserNotifier userNotifier = Provider.of<UserNotifier>(context, listen: false);
    AppUser? user = userNotifier.currentUser;
    if (user == null) return;

    List<Event> _eventList = [];

    try {
      // Find all events
      QuerySnapshot snapshot = await _eventRef.where(EventFields.plantUid, whereIn: user.plantUids).get();

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
