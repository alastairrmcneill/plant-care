import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:plant_care/general/models/models.dart';
import 'package:plant_care/general/notifiers/notifiers.dart';
import 'package:plant_care/general/services/services.dart';
import 'package:plant_care/general/widgets/widgets.dart';
import 'package:plant_care/support/constants.dart';
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
        actions: [
          PopupMenuButton(
            icon: const Icon(Icons.more_vert_rounded),
            onSelected: (value) async {
              if (value == MenuItems.item1) {
                showTwoButtonDialog(
                  context,
                  "Share this code: ${household.code}",
                  'Copy',
                  () async {
                    Clipboard.setData(ClipboardData(text: household.code));
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          "Household code copied to clipboard",
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                  },
                  'Cancel',
                  () {},
                );
              } else if (value == MenuItems.item2) {
                await HouseholdService.editHousehold(context, household: household);
              } else if (value == MenuItems.item3) {
                await HouseholdService.removeCurrentUser(context, household: household);
              }
            },
            itemBuilder: (context) => const [
              PopupMenuItem(
                value: MenuItems.item1,
                child: Text('Share'),
              ),
              PopupMenuItem(
                value: MenuItems.item2,
                child: Text('Edit'),
              ),
              PopupMenuItem(
                value: MenuItems.item3,
                child: Text('Leave'),
              ),
            ],
          ),
        ],
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
