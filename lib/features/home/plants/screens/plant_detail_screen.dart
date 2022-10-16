import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:plant_care/general/widgets/calendar.dart';
import 'package:plant_care/features/home/plants/widgets/plant_header_photo.dart';
import 'package:plant_care/features/home/plants/widgets/widgets.dart';
import 'package:plant_care/general/models/models.dart';
import 'package:plant_care/general/notifiers/notifiers.dart';
import 'package:plant_care/general/services/services.dart';
import 'package:plant_care/support/constants.dart';
import 'package:provider/provider.dart';

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
        child: SingleChildScrollView(
          child: Column(
            children: [
              PlantHeaderPhoto(photoURL: plant.photoURL, initials: plant.name[0]),
              Calendar(onTap: (details) {}, events: eventNotifier.currentPlantEvents),
              const Text('Upcoming Tasks'),
              ...eventNotifier.currentPlantEvents.map((event) => TaskTile(event: event)).toList()
            ],
          ),
        ),
      ),
    );
  }
}
