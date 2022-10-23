import 'package:flutter/material.dart';
import 'package:plant_care/features/home/plants/widgets/widgets.dart';
import 'package:plant_care/general/notifiers/notifiers.dart';
import 'package:provider/provider.dart';

class OverviewTab extends StatelessWidget {
  const OverviewTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    EventNotifier eventNotifier = Provider.of<EventNotifier>(context);

    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 150),
          ...eventNotifier.currentPlantEvents.map((event) => TaskTile(event: event)).toList(),
        ],
      ),
    );
  }
}
