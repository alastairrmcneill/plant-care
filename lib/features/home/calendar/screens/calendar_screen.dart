import 'package:flutter/material.dart';
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
                // allowedViews: const [
                //   CalendarView.day,
                //   CalendarView.month,
                // ],
                firstDayOfWeek: 1,
                initialDisplayDate: DateTime.now(),
                showDatePickerButton: true,
                showNavigationArrow: false,
                dataSource: MeetingDataSource(getAppointments()),
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

List<Appointment> getAppointments() {
  List<Appointment> meetings = [];
  final DateTime today = DateTime.now();
  final DateTime startTime = DateTime(today.year, today.month, today.day, 9, 0, 0);
  final DateTime endTime = DateTime(today.year, today.month, today.day, 10, 0, 0);
  meetings.add(
    Appointment(
      startTime: startTime,
      endTime: endTime,
      color: Colors.lightBlueAccent,
      subject: 'Plant Name - Mist',
      recurrenceRule: "FREQ=DAILY;INTERVAL=2",
    ),
  );
  meetings.add(
    Appointment(
      startTime: startTime,
      endTime: endTime,
      color: Colors.greenAccent,
      subject: 'Plant Name - Food',
      recurrenceRule: "FREQ=DAILY;INTERVAL=2",
    ),
  );
  meetings.add(
    Appointment(
      startTime: startTime,
      endTime: endTime,
      color: Colors.blueAccent,
      subject: 'Plant Name - Water',
      recurrenceRule: "FREQ=DAILY;INTERVAL=2",
    ),
  );

  return meetings;
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Appointment> source) {
    appointments = source;
  }
}
