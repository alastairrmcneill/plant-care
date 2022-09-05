import 'package:flutter/material.dart';
import 'package:plant_care/features/home/plants/screens/screens.dart';
import 'package:plant_care/features/home/plants/widgets/widgets.dart';

class PlantsScreen extends StatelessWidget {
  const PlantsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const CreatePlantScreen())),
        child: const Icon(Icons.add),
      ),
      body: const SafeArea(child: PlantBody()),
    );
  }
}
