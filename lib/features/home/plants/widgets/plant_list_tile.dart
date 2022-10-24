import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:plant_care/features/home/plants/screens/screens.dart';
import 'package:plant_care/general/models/models.dart';
import 'package:plant_care/general/notifiers/notifiers.dart';
import 'package:plant_care/general/services/event_service.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class PlantListTile extends StatelessWidget {
  final Plant plant;
  const PlantListTile({Key? key, required this.plant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PlantNotifier plantNotifier = Provider.of<PlantNotifier>(context);
    HouseholdNotifier householdNotifier = Provider.of<HouseholdNotifier>(context);
    EventNotifier eventNotifier = Provider.of<EventNotifier>(context);

    List<Household> myHouseholds = householdNotifier.myHouseholds!;
    Household household = myHouseholds.where((household) => household.uid == plant.householdUid).first;
    List<Event> events = eventNotifier.allEvents.where((event) => event.plantUid == plant.uid).toList();

    Widget _buildActionEntry(String type) {
      String dueString = '';
      DateTime now = DateTime.now();
      now = DateTime(now.year, now.month, now.day);

      if (events.isNotEmpty) {
        List<Event> actionEvents = events.where((event) => event.type == type).toList();
        if (actionEvents.isEmpty) return Container();

        Event event = actionEvents.first;

        if (event.nextAction.isAtSameMomentAs(now)) {
          dueString = 'Due today';
        } else if (event.nextAction.isBefore(now)) {
          dueString = 'Overdue';
        } else if (event.nextAction.isAfter(now)) {
          int daysUntil = event.nextAction.difference(now).inDays;
          if (daysUntil == 1) {
            dueString = 'Due in 1 day';
          } else {
            dueString = 'Due in $daysUntil days';
          }
        }
      }

      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '- $type',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w300,
            ),
          ),
          Text(
            dueString,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w300,
            ),
          )
        ],
      );
    }

    return GestureDetector(
      onTap: () {
        plantNotifier.setCurrentPlant = plant;
        EventService.getCurrentPlantEvents(context);
        Navigator.push(context, MaterialPageRoute(builder: (_) => const PlantDetailScreen()));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 18),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Container(
            padding: const EdgeInsets.all(10),
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF15CAB8), Color(0xFF109C8E)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Card(
                      elevation: 5,
                      shape: const CircleBorder(),
                      child: CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          radius: 18,
                          backgroundColor: Colors.grey[400],
                          backgroundImage: plant.photoURL != null ? CachedNetworkImageProvider(plant.photoURL!) : null,
                          child: plant.photoURL != null
                              ? null
                              : Text(
                                  plant.name[0],
                                  style: TextStyle(fontSize: 20, color: Colors.grey[700]),
                                ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      plant.name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                const Divider(color: Colors.white, thickness: 1),
                const Text(
                  'Actions',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                _buildActionEntry(EventTypes.water),
                _buildActionEntry(EventTypes.mist),
                _buildActionEntry(EventTypes.feed),
                const SizedBox(height: 10),
                const Text(
                  'Household',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  '- ${household.name}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
