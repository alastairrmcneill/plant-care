import 'package:flutter/material.dart';
import 'package:plant_care/features/home/plants/screens/screens.dart';
import 'package:plant_care/general/models/models.dart';
import 'package:plant_care/general/notifiers/notifiers.dart';
import 'package:plant_care/general/services/event_service.dart';
import 'package:provider/provider.dart';

class PlantListTile extends StatelessWidget {
  final Plant plant;
  const PlantListTile({Key? key, required this.plant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PlantNotifier plantNotifier = Provider.of<PlantNotifier>(context);
    return GestureDetector(
      onTap: () {
        plantNotifier.setCurrentPlant = plant;
        EventService.getCurrentPlantEvents(context);
        Navigator.push(context, MaterialPageRoute(builder: (_) => const PlantDetailScreen()));
      },
      child: Container(
        height: 100,
        color: Colors.blue,
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.all(10),
        child: Text(plant.name),
      ),
    );
  }
}
