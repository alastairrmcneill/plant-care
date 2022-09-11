import 'package:flutter/material.dart';
import 'package:plant_care/general/models/models.dart';
import 'package:plant_care/general/notifiers/notifiers.dart';
import 'package:plant_care/general/services/services.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class PlantDetailScreen extends StatefulWidget {
  const PlantDetailScreen({Key? key}) : super(key: key);

  @override
  State<PlantDetailScreen> createState() => _PlantDetailScreenState();
}

class _PlantDetailScreenState extends State<PlantDetailScreen> {
  @override
  void initState() {
    super.initState();
    // EventService.getCurrentPlantEvents(context);
  }

  @override
  Widget build(BuildContext context) {
    PlantNotifier plantNotifier = Provider.of<PlantNotifier>(context);
    EventNotifier eventNotifier = Provider.of<EventNotifier>(context);
    Plant plant = plantNotifier.currentPlant!;
    return Scaffold(
      appBar: AppBar(
        title: Text(plant.name),
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
                dataSource: MeetingDataSource(eventNotifier.currentPlantEvents),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                await PlantService.removePlantFromHousehold(context, plant: plant);
              },
              child: Text('Delete plant'),
            ),
            ElevatedButton(
              onPressed: () async {
                await PlantService.updatePlant(
                  context,
                  originalPlant: plant,
                  name: 'New name',
                  wateringDays: [true],
                  wateringRecurrence: '1 week',
                  wateringNotes: 'Hello',
                  mistingDays: [false],
                  mistingRecurrence: '1 weeks',
                  mistingNotes: '',
                  feedingDays: [false],
                  feedingRecurrence: '1 week',
                  feedingNotes: '',
                );
              },
              child: Text('Update plant'),
            ),
          ],
        ),
      ),
    );
  }
}
