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
    required String householdUid,
    required List<bool> days,
    required String recurrence,
    required String notes,
    required String type,
    required String subject,
    required String notifcationMessage,
  }) async {
    final DateTime today = DateTime.now();
    final DateTime startTime = DateTime(today.year, today.month, today.day, 0, 0, 0);
    final DateTime endTime = DateTime(today.year, today.month, today.day, 0, 0, 1);

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

    List<DateTime> futureAppointments = SfCalendar.getRecurrenceDateTimeCollection(
      '$recurrenceRule;COUNT=1000',
      startTime,
      specificStartDate: today,
      specificEndDate: today.add(const Duration(days: 50)),
    );
    DateTime nextAction = futureAppointments.first;
    if (startTime == DateTime(nextAction.year, nextAction.month, nextAction.day)) {
      nextAction = futureAppointments[1];
    }

    // Create Event
    Event event = Event(
      plantUid: plantUid,
      householdUid: householdUid,
      startTime: startTime,
      endTime: endTime,
      lastAction: DateTime(today.year, today.month, today.day),
      nextAction: DateTime(nextAction.year, nextAction.month, nextAction.day),
      subject: subject,
      recurrenceRule: recurrenceRule,
      days: days,
      repeats: recurrence,
      type: type,
      notes: notes,
      notificationMessage: notifcationMessage,
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
    return Appointment(
      startTime: event.startTime,
      endTime: event.endTime,
      color: eventColors[event.type]!,
      subject: event.uid!,
      recurrenceRule: event.recurrenceRule,
    );
  }

  static Future markAsDone(BuildContext context, Event event, Appointment appointment) async {
    DateTime now = appointment.startTime;
    DateTime lastAction = DateTime(now.year, now.month, now.day);
    List<DateTime> futureDates = SfCalendar.getRecurrenceDateTimeCollection(
      '${event.recurrenceRule};COUNT=1000',
      event.startTime,
      specificStartDate: now,
      specificEndDate: now.add(Duration(days: 100)),
    );
    DateTime nextAction = futureDates[1];

    Event newEvent = event.copy(
      lastAction: lastAction,
      nextAction: nextAction,
    );

    // Update database
    await EventDatabase.updateEvent(context, event: newEvent);
    getCurrentPlantEvents(context);
  }

  static Future markOverdueTileAsDone(BuildContext context, Event event) async {
    DateTime now = DateTime.now();
    DateTime lastAction = DateTime(now.year, now.month, now.day);
    List<DateTime> futureDates = SfCalendar.getRecurrenceDateTimeCollection(
      '${event.recurrenceRule};COUNT=1000',
      event.startTime,
      specificStartDate: now.add(Duration(days: 1)),
      specificEndDate: now.add(Duration(days: 100)),
    );
    DateTime nextAction = futureDates[0];

    Event newEvent = event.copy(
      lastAction: lastAction,
      nextAction: nextAction,
    );

    // Update database
    await EventDatabase.updateEvent(context, event: newEvent);
    getCurrentPlantEvents(context);
  }

  static Future markAsUndone(BuildContext context, Event event, Appointment appointment) async {
    DateTime lastAction = event.startTime;
    DateTime nextAction = appointment.startTime;

    List<DateTime> futureDates = SfCalendar.getRecurrenceDateTimeCollection(
      '${event.recurrenceRule};COUNT=1000',
      event.startTime,
    );
    int index = futureDates.indexOf(appointment.startTime);

    if (index != 0) {
      lastAction = futureDates[index - 1];
    }

    Event newEvent = event.copy(
      lastAction: lastAction,
      nextAction: nextAction,
    );

    // Update database
    await EventDatabase.updateEvent(context, event: newEvent);
    getCurrentPlantEvents(context);
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
