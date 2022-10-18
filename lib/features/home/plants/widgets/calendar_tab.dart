import 'package:flutter/material.dart';
import 'package:plant_care/features/home/calendar/widgets/widgets.dart';
import 'package:plant_care/general/notifiers/notifiers.dart';
import 'package:plant_care/general/widgets/widgets.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalendarTab extends StatefulWidget {
  const CalendarTab({Key? key}) : super(key: key);

  @override
  State<CalendarTab> createState() => _CalendarTabState();
}

class _CalendarTabState extends State<CalendarTab> {
  List<Appointment> selectedDateAppointments = [];

  @override
  Widget build(BuildContext context) {
    EventNotifier eventNotifier = Provider.of<EventNotifier>(context);

    return Column(
      children: [
        const SizedBox(height: 150),
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
          flex: 1,
          child: SingleChildScrollView(
            child: Column(
              children: selectedDateAppointments.map((appointment) {
                return OccuranceTile(appointment: appointment);
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}
