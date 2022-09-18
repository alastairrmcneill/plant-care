import 'package:flutter/material.dart';
import 'package:plant_care/general/models/models.dart';
import 'package:plant_care/general/services/services.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class Calendar extends StatelessWidget {
  final void Function(CalendarTapDetails) onTap;
  final List<Event> events;
  const Calendar({Key? key, required this.onTap, required this.events}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        gradient: const LinearGradient(
          colors: [Color(0xFF15CAB8), Color(0xFF109C8E)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      height: 300,
      margin: const EdgeInsets.all(10),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
        ),
        margin: const EdgeInsets.all(1),
        padding: const EdgeInsets.all(10),
        child: SfCalendar(
          view: CalendarView.month,
          initialSelectedDate: DateTime.now(),
          onTap: (calendarTapDetails) {
            onTap(calendarTapDetails);
          },
          firstDayOfWeek: 1,
          initialDisplayDate: DateTime.now(),
          showDatePickerButton: false,
          showNavigationArrow: true,
          cellBorderColor: Colors.white,
          headerDateFormat: 'MMM, y',
          headerStyle: const CalendarHeaderStyle(
            textAlign: TextAlign.center,
            textStyle: TextStyle(
              color: Colors.teal,
            ),
          ),
          monthViewSettings: MonthViewSettings(
            dayFormat: 'EEE',
            appointmentDisplayCount: 3,
            showTrailingAndLeadingDates: false,
            monthCellStyle: MonthCellStyle(
              textStyle: const TextStyle(color: Colors.teal, fontWeight: FontWeight.w300),
              trailingDatesTextStyle: TextStyle(color: Colors.grey[400], fontWeight: FontWeight.w300),
              leadingDatesTextStyle: TextStyle(color: Colors.grey[400], fontWeight: FontWeight.w300),
            ),
          ),
          viewHeaderStyle: const ViewHeaderStyle(
            dayTextStyle: TextStyle(color: Colors.teal, fontWeight: FontWeight.w300, fontSize: 10),
          ),
          selectionDecoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.teal, width: 1),
          ),
          dataSource: MeetingDataSource(events),
        ),
      ),
    );
  }
}
