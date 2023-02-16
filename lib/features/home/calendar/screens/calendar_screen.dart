import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:plant_care/general/notifiers/notifiers.dart';
import 'package:plant_care/general/widgets/widgets.dart';
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
    UserNotifier userNotifier = Provider.of<UserNotifier>(context);
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent, // <-- SEE HERE
          statusBarIconBrightness: Brightness.dark, //<-- For Android SEE HERE (dark icons)
          statusBarBrightness: Brightness.light, //<-- For iOS SEE HERE (dark icons)
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hello ${userNotifier.currentUser?.name.split(' ')[0]}! 👋',
              style: const TextStyle(fontWeight: FontWeight.w400),
            ),
            const Text(
              'Your calendar:',
              style: TextStyle(fontWeight: FontWeight.w200, fontSize: 16),
            ),
          ],
        ),
        centerTitle: false,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        shadowColor: Colors.transparent,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
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
              ...selectedDateAppointments.map((appointment) {
                return EventTile(appointment: appointment);
              }).toList(),
            ],
          ),
        ),
      ),
    );
  }
}
