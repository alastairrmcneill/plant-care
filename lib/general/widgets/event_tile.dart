import 'package:auto_size_text/auto_size_text.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/cil.dart';
import 'package:plant_care/general/models/models.dart';
import 'package:plant_care/general/notifiers/notifiers.dart';
import 'package:plant_care/general/services/event_service.dart';
import 'package:plant_care/general/widgets/widgets.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class EventTile extends StatelessWidget {
  final Appointment appointment;
  const EventTile({Key? key, required this.appointment}) : super(key: key);

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

    return GestureDetector(
      onTap: () {
        if (event.notes != "") {
          showOneButtonDialog(context, event.notes, "Done", () async {});
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          decoration: BoxDecoration(
            color: eventColors[event.type],
            borderRadius: BorderRadius.circular(10),
          ),
          width: double.infinity,
          child: Row(
            children: [
              // Icon
              SizedBox(
                width: 30,
                child: eventIcons[event.type]!,
              ),
              const SizedBox(width: 10),
              // Name and type
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Name
                    AutoSizeText(
                      plant.name,
                      maxLines: 1,
                      maxFontSize: 25,
                      minFontSize: 16,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: eventAccentColors[event.type], fontWeight: FontWeight.w300, fontSize: 25),
                    ),
                    const SizedBox(height: 4),
                    // Type and Notes
                    Row(
                      children: [
                        Text(
                          event.type,
                          style: TextStyle(color: eventAccentColors[event.type], fontWeight: FontWeight.w300, fontSize: 14),
                        ),
                        event.notes == ""
                            ? const SizedBox()
                            : Text(
                                " - ",
                                style: TextStyle(color: eventAccentColors[event.type], fontWeight: FontWeight.w300, fontSize: 14),
                              ),
                        event.notes == ""
                            ? const SizedBox()
                            : Icon(
                                FluentSystemIcons.ic_fluent_clipboard_text_regular,
                                color: eventAccentColors[event.type],
                                size: 16,
                              ),
                      ],
                    ),
                  ],
                ),
              ),
              // Checkbox
              Checkbox(
                fillColor: MaterialStateProperty.all<Color?>(eventAccentColors[event.type]),
                side: BorderSide(color: eventAccentColors[event.type]!),
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
        ),
      ),
    );
  }
}
