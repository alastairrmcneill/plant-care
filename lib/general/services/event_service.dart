import 'package:flutter/material.dart';
import 'package:plant_care/general/models/models.dart';
import 'package:plant_care/general/notifiers/notifiers.dart';
import 'package:plant_care/general/services/services.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class EventService {
  static Future create(
    BuildContext context, {
    required String plantUid,
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
      plantUid: plantUid,
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

  static getCurrentPlantEvents(BuildContext context) {
    PlantNotifier plantNotifier = Provider.of<PlantNotifier>(context, listen: false);
    EventNotifier eventNotifier = Provider.of<EventNotifier>(context, listen: false);

    List<Event> allEvents = eventNotifier.allEvents;
    List<Event> currentPlantEvents = [];

    Plant? plant = plantNotifier.currentPlant;
    if (plant != null && allEvents.isNotEmpty) {
      for (var event in allEvents) {
        if (event.plantUid == plant.uid) {
          currentPlantEvents.add(event);
        }
      }
    }

    eventNotifier.setCurrentPlantEvents = currentPlantEvents;
  }

  static getCurrentHouseholdEvents(BuildContext context) {
    HouseholdNotifier householdNotifier = Provider.of<HouseholdNotifier>(context, listen: false);
    EventNotifier eventNotifier = Provider.of<EventNotifier>(context, listen: false);

    List<Event> allEvents = eventNotifier.allEvents;
    List<Event> currentHouseholdEvents = [];

    Household? household = householdNotifier.currentHousehold;
    if (household != null && allEvents.isNotEmpty) {
      for (var event in allEvents) {
        if (household.plantsInfo.keys.contains(event.plantUid)) {
          currentHouseholdEvents.add(event);
        }
      }
    }

    eventNotifier.setCurrentHouseholdEvents = currentHouseholdEvents;
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
      subject: event.uid!,
      recurrenceRule: event.recurrenceRule,
    );
  }
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Event> source) {
    // convert list of events to list of appointments for calendar
    List<Appointment> _appointmentList = [];
    for (var event in source) {
      _appointmentList.add(EventService.eventToAppointment(event));
    }
    appointments = _appointmentList;
  }
}
