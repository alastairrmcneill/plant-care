import 'package:cloud_firestore/cloud_firestore.dart';

class Event {
  final String? uid;
  final DateTime startTime;
  final DateTime endTime;
  final String subject;
  final String recurrenceRule;
  final String type;

  Event({
    this.uid,
    required this.startTime,
    required this.endTime,
    required this.subject,
    required this.recurrenceRule,
    required this.type,
  });

  Map<String, Object?> toJson() {
    return {
      EventFields.uid: uid,
      EventFields.startTime: startTime,
      EventFields.endTime: endTime,
      EventFields.subject: subject,
      EventFields.recurrenceRule: recurrenceRule,
      EventFields.type: type,
    };
  }

  static Event fromJson(json) {
    return Event(
      uid: json[EventFields.uid] as String?,
      startTime: (json[EventFields.startTime] as Timestamp).toDate(),
      endTime: (json[EventFields.endTime] as Timestamp).toDate(),
      subject: json[EventFields.subject] as String,
      recurrenceRule: json[EventFields.recurrenceRule] as String,
      type: json[EventFields.type] as String,
    );
  }

  Event copy({
    String? uid,
    DateTime? startTime,
    DateTime? endTime,
    String? subject,
    String? recurrenceRule,
    String? type,
  }) =>
      Event(
        uid: uid ?? this.uid,
        startTime: startTime ?? this.startTime,
        endTime: endTime ?? this.endTime,
        subject: subject ?? this.subject,
        recurrenceRule: recurrenceRule ?? this.recurrenceRule,
        type: type ?? this.type,
      );
}

class EventFields {
  static String uid = 'uid';
  static String startTime = 'startTime';
  static String endTime = 'endTime';
  static String subject = 'subject';
  static String recurrenceRule = 'recurrenceRule';
  static String type = 'type';
}
