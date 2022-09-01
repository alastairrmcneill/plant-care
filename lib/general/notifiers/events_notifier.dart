import 'package:flutter/material.dart';
import 'package:plant_care/general/models/models.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class EventNotifier extends ChangeNotifier {
  List<Event> _allEvents = [];
  List<Appointment> _allAppointments = [];

  List<Event> get allEvents => _allEvents;
  List<Appointment> get allAppointments => _allAppointments;

  set setAllEvents(List<Event> allEvents) {
    _allEvents = allEvents;
    notifyListeners();
  }

  set setAllAppointments(List<Appointment> allAppointments) {
    _allAppointments = allAppointments;
    notifyListeners();
  }
}
