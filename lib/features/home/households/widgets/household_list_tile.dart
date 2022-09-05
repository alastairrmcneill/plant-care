import 'package:flutter/material.dart';
import 'package:plant_care/features/home/households/screens/screens.dart';
import 'package:plant_care/general/models/models.dart';
import 'package:plant_care/general/notifiers/household_notifier.dart';
import 'package:provider/provider.dart';

class HouseholdListTile extends StatelessWidget {
  final Household household;
  const HouseholdListTile({Key? key, required this.household}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HouseholdNotifier householdNotifier = Provider.of<HouseholdNotifier>(context);
    return GestureDetector(
      onTap: () {
        householdNotifier.setCurrentHousehold = household;
        Navigator.push(context, MaterialPageRoute(builder: (_) => const HouseholdDetailScreen()));
      },
      child: Container(
        height: 100,
        color: Colors.blue,
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.all(10),
        child: Text(household.name),
      ),
    );
  }
}
