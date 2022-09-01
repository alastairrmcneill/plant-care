import 'package:flutter/material.dart';
import 'package:plant_care/general/models/models.dart';
import 'package:plant_care/general/services/services.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class EventService {
  static Future create(
    BuildContext context, {
    required List<bool> days,
    required String recurrence,
    required String? notes,
    required String type,
    required String subject,
  }) async {
    final DateTime today = DateTime.now();
    final DateTime startTime = DateTime(today.year, today.month, today.day, 9, 0, 0);
    final DateTime endTime = DateTime(today.year, today.month, today.day, 10, 0, 0);

    String recurrenceRule = 'FREQ=WEEKLY';
    String byDay = 'BYDAY=';
    String interval = 'INTERVAL=';
    List<String> weekDays = ['MO,', 'TU,', 'WE,', 'TH,', 'FR,', 'SA,', 'SU,'];
    for (var i = 0; i <= days.length - 1; i++) {
      if (days[i] == true) {
        byDay += weekDays[i];
      }
    }
    byDay = byDay.substring(0, byDay.length - 1);

    interval += recurrence[0];

    recurrenceRule += ';$byDay;$interval';

    // Create Event
    Event event = Event(
      startTime: startTime,
      endTime: endTime,
      subject: subject,
      recurrenceRule: recurrenceRule,
      type: type,
      notes: notes,
    );

    // Save event
    await EventDatabase.create(context, event: event);
  }

  static Appointment eventToAppointment(Event event) {
    Color color = Colors.blue;
    if (event.type == 'water') {
      color = Colors.blue;
    } else if (event.type == 'misting') {
      color = Colors.blueGrey;
    } else if (event.type == 'feeding') {
      color = Colors.green;
    }
    return Appointment(
      startTime: event.startTime,
      endTime: event.endTime,
      color: color,
      subject: event.subject,
      recurrenceRule: event.recurrenceRule,
    );
  }

  static appintmentToEvent() {}
}
