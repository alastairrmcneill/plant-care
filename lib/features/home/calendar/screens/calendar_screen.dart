import 'package:flutter/material.dart';
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
  void initState() {
    super.initState();
    EventDatabase.readAllEvents(context);
  }

  @override
  Widget build(BuildContext context) {
    EventNotifier eventNotifier = Provider.of<EventNotifier>(context, listen: true);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 300,
              child: SfCalendar(
                view: CalendarView.month,
                initialSelectedDate: DateTime.now(),
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
                firstDayOfWeek: 1,
                initialDisplayDate: DateTime.now(),
                showDatePickerButton: true,
                showNavigationArrow: false,
                dataSource: MeetingDataSource(eventNotifier.allAppointments),
              ),
            ),
            Expanded(
              child: ListView(
                children: selectedDateAppointments.map((e) => Text(e.subject)).toList(),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {},
      ),
    );
  }
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Appointment> source) {
    appointments = source;
  }
}
