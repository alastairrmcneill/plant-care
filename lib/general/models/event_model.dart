import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/cil.dart';
import 'package:plant_care/general/models/models.dart';

class Event {
  final String? uid;
  final String plantUid;
  final String householdUid;
  final DateTime startTime;
  final DateTime endTime;
  final DateTime lastAction;
  final DateTime nextAction;
  final String subject;
  final String recurrenceRule;
  final List<bool> days;
  final String repeats;
  final String type;
  final String notes;
  final String notificationMessage;

  Event({
    this.uid,
    required this.plantUid,
    required this.householdUid,
    required this.startTime,
    required this.endTime,
    required this.lastAction,
    required this.nextAction,
    required this.subject,
    required this.recurrenceRule,
    required this.days,
    required this.repeats,
    required this.type,
    required this.notes,
    required this.notificationMessage,
  });

  Map<String, Object?> toJson() {
    return {
      EventFields.uid: uid,
      EventFields.plantUid: plantUid,
      EventFields.householdUid: householdUid,
      EventFields.startTime: startTime,
      EventFields.endTime: endTime,
      EventFields.lastAction: lastAction,
      EventFields.nextAction: nextAction,
      EventFields.subject: subject,
      EventFields.recurrenceRule: recurrenceRule,
      EventFields.days: days,
      EventFields.repeats: repeats,
      EventFields.type: type,
      EventFields.notes: notes,
      EventFields.notificationMessage: notificationMessage,
    };
  }

  static Event fromJson(json) {
    List<dynamic> days = json[EventFields.days];
    List<bool> newDays = List<bool>.from(days);
    return Event(
      uid: json[EventFields.uid] as String?,
      plantUid: json[EventFields.plantUid] as String,
      householdUid: json[EventFields.householdUid] as String,
      startTime: (json[EventFields.startTime] as Timestamp).toDate(),
      endTime: (json[EventFields.endTime] as Timestamp).toDate(),
      lastAction: (json[EventFields.lastAction] as Timestamp).toDate(),
      nextAction: (json[EventFields.nextAction] as Timestamp).toDate(),
      subject: json[EventFields.subject] as String,
      recurrenceRule: json[EventFields.recurrenceRule] as String,
      days: newDays,
      repeats: json[EventFields.repeats] as String,
      type: json[EventFields.type] as String,
      notes: json[EventFields.notes] as String,
      notificationMessage: json[EventFields.notificationMessage] as String? ?? 'You have a plant that needs attention',
    );
  }

  Event copy({
    String? uid,
    String? plantUid,
    String? householdUid,
    DateTime? startTime,
    DateTime? endTime,
    DateTime? lastAction,
    DateTime? nextAction,
    String? subject,
    String? recurrenceRule,
    List<bool>? days,
    String? repeats,
    String? type,
    String? notes,
    String? notificationMessage,
  }) =>
      Event(
        uid: uid ?? this.uid,
        plantUid: plantUid ?? this.plantUid,
        householdUid: householdUid ?? this.householdUid,
        startTime: startTime ?? this.startTime,
        endTime: endTime ?? this.endTime,
        lastAction: lastAction ?? this.lastAction,
        nextAction: nextAction ?? this.nextAction,
        subject: subject ?? this.subject,
        recurrenceRule: recurrenceRule ?? this.recurrenceRule,
        days: days ?? this.days,
        repeats: repeats ?? this.repeats,
        type: type ?? this.type,
        notes: notes ?? this.notes,
        notificationMessage: notificationMessage ?? this.notificationMessage,
      );
}

class EventFields {
  static String uid = 'uid';
  static String plantUid = 'plantUid';
  static String householdUid = 'householdUid';
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
  static String days = 'days';
  static String repeats = 'repeats';
  static String notificationMessage = 'notificationMessage';
}

class EventTypes {
  static String water = 'Water';
  static String feed = 'Feed';
  static String mist = 'Mist';
}

Map<String, Widget> eventIcons = {
  EventTypes.water: Icon(
    Icons.water_drop_outlined,
    color: eventAccentColors[EventTypes.water],
    size: 30,
  ),
  EventTypes.mist: Iconify(
    Cil.grain,
    color: eventAccentColors[EventTypes.mist],
    size: 25,
  ),
  EventTypes.feed: Icon(
    FluentSystemIcons.ic_fluent_food_regular,
    color: eventAccentColors[EventTypes.feed],
    size: 30,
  ),
};
Map<String, Color> eventColors = {
  EventTypes.water: Color.fromARGB(255, 118, 179, 245),
  EventTypes.mist: Color.fromARGB(255, 213, 131, 227),
  EventTypes.feed: Color.fromARGB(255, 132, 187, 135),
};

Map<String, Color> eventAccentColors = {
  EventTypes.water: Color.fromARGB(255, 0, 59, 122),
  EventTypes.mist: Color.fromARGB(255, 88, 0, 103),
  EventTypes.feed: Color.fromARGB(255, 0, 84, 4),
};
