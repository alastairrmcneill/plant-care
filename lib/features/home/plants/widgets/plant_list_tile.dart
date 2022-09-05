import 'package:flutter/material.dart';
import 'package:plant_care/general/models/models.dart';

class PlantListTile extends StatelessWidget {
  final Plant plant;
  const PlantListTile({Key? key, required this.plant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // householdNotifier.setCurrentHousehold = household;
        // Navigator.push(context, MaterialPageRoute(builder: (_) => const HouseholdDetailScreen()));
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
