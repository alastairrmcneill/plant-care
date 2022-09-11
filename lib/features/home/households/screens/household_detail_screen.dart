import 'package:flutter/material.dart';
import 'package:plant_care/general/models/models.dart';
import 'package:plant_care/general/notifiers/notifiers.dart';
import 'package:plant_care/general/services/services.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class HouseholdDetailScreen extends StatelessWidget {
  const HouseholdDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HouseholdNotifier householdNotifier = Provider.of<HouseholdNotifier>(context);
    EventNotifier eventNotifier = Provider.of<EventNotifier>(context);
    Household household = householdNotifier.currentHousehold!;
    return Scaffold(
      appBar: AppBar(
        title: Text(household.name),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 300,
              child: SfCalendar(
                view: CalendarView.month,
                initialSelectedDate: DateTime.now(),
                // onTap: (calendarTapDetails) {
                //   selectedDateAppointments = [];
                //   if (calendarTapDetails.appointments != null && calendarTapDetails.appointments!.isNotEmpty) {
                //     // Loop through appointments and store them as Appointment
                //     for (var appointment in calendarTapDetails.appointments!) {
                //       Appointment app = appointment as Appointment;
                //       selectedDateAppointments.add(app);
                //     }
                //   }
                //   setState(() {});
                // },
                firstDayOfWeek: 1,
                initialDisplayDate: DateTime.now(),
                showDatePickerButton: true,
                showNavigationArrow: false,
                dataSource: MeetingDataSource(eventNotifier.currentHouseholdEvents),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                await HouseholdService.removeCurrentUser(context, household: household);
              },
              child: Text('Leave'),
            ),
            ElevatedButton(
              onPressed: () async {
                await HouseholdService.editHousehold(context, household: household);
              },
              child: Text('Edit'),
            ),
          ],
        ),
      ),
    );
  }
}
