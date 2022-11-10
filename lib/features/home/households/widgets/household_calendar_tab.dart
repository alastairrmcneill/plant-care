import 'package:flutter/material.dart';
import 'package:plant_care/general/notifiers/notifiers.dart';
import 'package:plant_care/general/widgets/widgets.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class HouseholdCalendarTab extends StatefulWidget {
  const HouseholdCalendarTab({Key? key}) : super(key: key);

  @override
  State<HouseholdCalendarTab> createState() => _CalendarTabState();
}

class _CalendarTabState extends State<HouseholdCalendarTab> {
  List<Appointment> selectedDateAppointments = [];

  @override
  Widget build(BuildContext context) {
    EventNotifier eventNotifier = Provider.of<EventNotifier>(context);
    return Column(
      children: [
        Calendar(
          events: eventNotifier.currentHouseholdEvents,
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
          flex: 1,
          child: SingleChildScrollView(
            child: Column(
              children: selectedDateAppointments.map((appointment) {
                return EventTile(appointment: appointment);
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}
