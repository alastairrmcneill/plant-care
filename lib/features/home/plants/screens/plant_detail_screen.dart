import 'package:flutter/material.dart';
import 'package:plant_care/features/home/plants/widgets/plant_header_photo.dart';
import 'package:plant_care/general/models/models.dart';
import 'package:plant_care/general/notifiers/notifiers.dart';
import 'package:plant_care/general/services/services.dart';
import 'package:plant_care/support/constants.dart';
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
        actions: [
          PopupMenuButton(
            icon: Icon(Icons.more_vert_rounded),
            onSelected: (value) async {
              if (value == MenuItems.item1) {
                print("Edit");
              } else if (value == MenuItems.item2) {
                await PlantService.removePlantFromHousehold(context, plant: plant);
              }
            },
            itemBuilder: (context) => const [
              PopupMenuItem(
                value: MenuItems.item1,
                child: Text('Edit'),
              ),
              PopupMenuItem(
                value: MenuItems.item2,
                child: Text('Delete'),
              ),
            ],
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            PlantHeaderPhoto(photoURL: plant.photoURL, initials: plant.name[0]),
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
          ],
        ),
      ),
    );
  }
}
