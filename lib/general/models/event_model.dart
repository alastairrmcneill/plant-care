import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:plant_care/general/models/models.dart';

class Event {
  final String? uid;
  final String plantUid;
  final DateTime startTime;
  final DateTime endTime;
  final DateTime lastAction;
  final DateTime nextAction;
  final String subject;
  final String recurrenceRule;
  final String type;
  final String notes;

  Event({
    this.uid,
    required this.plantUid,
    required this.startTime,
    required this.endTime,
    required this.lastAction,
    required this.nextAction,
    required this.subject,
    required this.recurrenceRule,
    required this.type,
    required this.notes,
  });

  Map<String, Object?> toJson() {
    return {
      EventFields.uid: uid,
      EventFields.plantUid: plantUid,
      EventFields.startTime: startTime,
      EventFields.endTime: endTime,
      EventFields.lastAction: lastAction,
      EventFields.nextAction: nextAction,
      EventFields.subject: subject,
      EventFields.recurrenceRule: recurrenceRule,
      EventFields.type: type,
      EventFields.notes: notes,
    };
  }

  static Event fromJson(json) {
    return Event(
      uid: json[EventFields.uid] as String?,
      plantUid: json[EventFields.plantUid] as String,
      startTime: (json[EventFields.startTime] as Timestamp).toDate(),
      endTime: (json[EventFields.endTime] as Timestamp).toDate(),
      lastAction: (json[EventFields.lastAction] as Timestamp).toDate(),
      nextAction: (json[EventFields.nextAction] as Timestamp).toDate(),
      subject: json[EventFields.subject] as String,
      recurrenceRule: json[EventFields.recurrenceRule] as String,
      type: json[EventFields.type] as String,
      notes: json[EventFields.notes] as String,
    );
  }

  Event copy({
    String? uid,
    String? plantUid,
    DateTime? startTime,
    DateTime? endTime,
    DateTime? lastAction,
    DateTime? nextAction,
    String? subject,
    String? recurrenceRule,
    String? type,
    String? notes,
  }) =>
      Event(
        uid: uid ?? this.uid,
        plantUid: plantUid ?? this.plantUid,
        startTime: startTime ?? this.startTime,
        endTime: endTime ?? this.endTime,
        lastAction: lastAction ?? this.lastAction,
        nextAction: nextAction ?? this.nextAction,
        subject: subject ?? this.subject,
        recurrenceRule: recurrenceRule ?? this.recurrenceRule,
        type: type ?? this.type,
        notes: notes ?? this.notes,
      );
}

class EventFields {
  static String uid = 'uid';
  static String plantUid = 'plantUid';
  static String startTime = 'startTime';
  static String endTime = 'endTime';
  static String lastAction = 'lastAction';
  static String nextAction = 'nextAction';
  static String subject = 'subject';
  static String recurrenceRule = 'recurrenceRule';
  static String type = 'type';
  static String notes = 'notes';
  static String watering = 'Watering';
  static String misting = 'Misting';
  static String feeding = 'Feeding';
}

class EventTypes {
  static String water = 'Water';
  static String feed = 'Feed';
  static String mist = 'Mist';
}

Map<String, IconData> eventIcons = {
  EventTypes.water: Icons.water_drop_outlined,
  EventTypes.feed: FontAwesomeIcons.bowlFood,
  EventTypes.mist: FontAwesomeIcons.sprayCan,
};
Map<String, Color> eventColors = {
  EventTypes.water: Color.fromARGB(255, 118, 179, 245),
  EventTypes.mist: Color.fromARGB(255, 213, 131, 227),
  EventTypes.feed: Color.fromARGB(255, 132, 187, 135),
};
