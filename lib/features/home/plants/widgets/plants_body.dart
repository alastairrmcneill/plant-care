import 'package:flutter/material.dart';
import 'package:plant_care/features/home/plants/widgets/widgets.dart';
import 'package:plant_care/general/notifiers/notifiers.dart';
import 'package:plant_care/general/services/plant_database.dart';
import 'package:provider/provider.dart';

class PlantBody extends StatefulWidget {
  const PlantBody({Key? key}) : super(key: key);

  @override
  State<PlantBody> createState() => _PlantBodyState();
}

class _PlantBodyState extends State<PlantBody> {
  Future _refresh() async {
    await PlantDatabase.readMyPlants(context);
  }

  Widget _buildBody() {
    PlantNotifier plantNotifier = Provider.of<PlantNotifier>(context);
    if (plantNotifier.myPlants == null) {
      return const Center(child: CircularProgressIndicator());
    } else if (plantNotifier.myPlants!.isEmpty) {
      return const Center(child: Text('Empty'));
    } else if (plantNotifier.myPlants!.isNotEmpty) {
      return const PlantListView();
    } else {
      return const Center(child: CircularProgressIndicator());
    }
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        child: _buildBody(),
        onRefresh: () async {
          await _refresh();
        });
  }
}
