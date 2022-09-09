import 'package:flutter/material.dart';
import 'package:plant_care/general/models/models.dart';
import 'package:plant_care/general/notifiers/notifiers.dart';
import 'package:plant_care/general/services/household_database.dart';
import 'package:plant_care/general/services/plant_service.dart';
import 'package:plant_care/general/widgets/widgets.dart';
import 'package:provider/provider.dart';

class PlantDetailScreen extends StatelessWidget {
  const PlantDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PlantNotifier plantNotifier = Provider.of<PlantNotifier>(context);
    Plant plant = plantNotifier.currentPlant!;
    return Scaffold(
      appBar: AppBar(
        title: Text(plant.name),
      ),
      body: Center(
        child: Column(
          children: [
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
