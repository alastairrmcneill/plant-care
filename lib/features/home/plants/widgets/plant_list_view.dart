import 'package:flutter/material.dart';
import 'package:plant_care/features/home/plants/widgets/widgets.dart';
import 'package:plant_care/general/models/plant_model.dart';
import 'package:plant_care/general/notifiers/notifiers.dart';
import 'package:provider/provider.dart';

class PlantListView extends StatelessWidget {
  const PlantListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PlantNotifier plantNotifier = Provider.of<PlantNotifier>(context);
    List<Plant> plants = plantNotifier.myPlants!;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: ListView(
        children: plants.map((plant) => PlantListTile(plant: plant)).toList(),
      ),
    );
  }
}
