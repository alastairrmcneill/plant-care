import 'package:flutter/material.dart';
import 'package:plant_care/features/home/households/widgets/widgets.dart';
import 'package:plant_care/general/models/models.dart';

class PlantsPhotoRow extends StatelessWidget {
  final Household household;
  const PlantsPhotoRow({Key? key, required this.household}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const ClampingScrollPhysics(),
      child: Stack(
        children: household.plantsInfo.values.toList().asMap().entries.map((value) {
          int index = value.key;
          Plant plant = Plant.fromJson(value.value);
          double offset = index * 25;
          return Padding(
            padding: EdgeInsets.only(left: offset),
            child: CircularPicture(
              photoUrl: plant.photoURL,
              text: plant.name[0],
            ),
          );
        }).toList(),
      ),
    );
  }
}
