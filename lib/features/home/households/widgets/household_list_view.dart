import 'package:flutter/material.dart';
import 'package:plant_care/features/home/households/widgets/widgets.dart';
import 'package:plant_care/general/models/models.dart';
import 'package:plant_care/general/notifiers/household_notifier.dart';
import 'package:plant_care/general/services/household_database.dart';
import 'package:provider/provider.dart';

class HouseholdListView extends StatelessWidget {
  const HouseholdListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HouseholdNotifier householdNotifier = Provider.of<HouseholdNotifier>(context);
    List<Household> households = householdNotifier.myHouseholds!;
    return ListView(
      children: households.map((household) => HouseholdListTile(household: household)).toList(),
    );
  }
}
