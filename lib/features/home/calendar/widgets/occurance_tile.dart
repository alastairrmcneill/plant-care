import 'package:flutter/material.dart';
import 'package:plant_care/general/models/models.dart';
import 'package:plant_care/general/notifiers/notifiers.dart';
import 'package:plant_care/general/services/event_service.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class OccuranceTile extends StatelessWidget {
  final Appointment appointment;
  const OccuranceTile({Key? key, required this.appointment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    EventNotifier eventNotifier = Provider.of<EventNotifier>(context, listen: false);
    PlantNotifier plantNotifier = Provider.of<PlantNotifier>(context, listen: false);
    List<Event> eventList = eventNotifier.allEvents;
    Iterable<Event> events = eventList.where((element) => (element.uid == appointment.subject));
    Event event = events.first;

    List<Plant> plantList = plantNotifier.myPlants!;
    Iterable<Plant> plants = plantList.where((element) => (element.uid == event.plantUid));
    Plant plant = plants.first;

    bool done = appointment.startTime.isBefore(event.lastAction) || appointment.startTime.isAtSameMomentAs(event.lastAction);

    return SizedBox(
      height: 100,
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(plant.name),
                Text(event.type),
                Text(event.nextAction.toString()),
              ],
            ),
          ),
          Checkbox(
            value: done,
            onChanged: (value) async {
              if (value!) {
                await EventService.markAsDone(context, event, appointment);
              } else {
                EventService.markAsUndone(context, event, appointment);
              }
            },
          )
        ],
      ),
    );
  }
}
