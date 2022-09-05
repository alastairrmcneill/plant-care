import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:plant_care/features/home/households/widgets/widgets.dart';
import 'package:plant_care/general/models/models.dart';
import 'package:plant_care/general/services/services.dart';

class HouseholdsScreen extends StatelessWidget {
  const HouseholdsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: HouseholdListView(),
      floatingActionButton: SpeedDial(
        icon: Icons.add,
        children: [
          SpeedDialChild(
            child: const Icon(Icons.add),
            label: 'Add Existing',
            onTap: () => showCreateHouseholdDialog(
              context,
              body: 'Enter the household sharing code to be added to it: ',
              hintText: 'Code',
              function: (code) async {
                // Maybe don't have these as async so that the pop up closes straight away. Add the spinning loading screen and then show a pop up depending on the result.
                HouseholdService.add(context, code: code);
              },
            ),
          ),
          SpeedDialChild(
            child: const Icon(Icons.create),
            label: 'Create new',
            onTap: () => showCreateHouseholdDialog(
              context,
              body: 'Please enter the name of the household:',
              hintText: 'Household name',
              function: (name) async {
                await HouseholdService.create(context, name: name);
                await HouseholdDatabase.readMyHouseholds(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}
