import 'package:flutter/material.dart';
import 'package:plant_care/features/home/calendar/widgets/widgets.dart';
import 'package:plant_care/general/models/models.dart';
import 'package:plant_care/general/notifiers/notifiers.dart';
import 'package:plant_care/general/services/services.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalendarScreen extends StatefulWidget {
  CalendarScreen({Key? key}) : super(key: key);

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  List<Appointment> selectedDateAppointments = [];

  @override
  Widget build(BuildContext context) {
    EventNotifier eventNotifier = Provider.of<EventNotifier>(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Calendar(
              events: eventNotifier.allEvents,
              onTap: (calendarTapDetails) {
                selectedDateAppointments = [];
                if (calendarTapDetails.appointments != null && calendarTapDetails.appointments!.isNotEmpty) {
                  // Loop through appointments and store them as Appointment
                  for (var appointment in calendarTapDetails.appointments!) {
                    Appointment app = appointment as Appointment;

                    selectedDateAppointments.add(app);
                  }
                }
                setState(() {});
              },
            ),
            Expanded(
              child: ListView(
                children: selectedDateAppointments.map((appointment) {
                  return OccuranceTile(appointment: appointment);
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
