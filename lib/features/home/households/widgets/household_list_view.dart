import 'package:flutter/material.dart';
import 'package:plant_care/general/notifiers/household_notifier.dart';
import 'package:plant_care/general/services/household_database.dart';
import 'package:provider/provider.dart';

class HouseholdListView extends StatefulWidget {
  const HouseholdListView({Key? key}) : super(key: key);

  @override
  State<HouseholdListView> createState() => _HouseholdListViewState();
}

class _HouseholdListViewState extends State<HouseholdListView> {
  @override
  void initState() {
    super.initState();
    HouseholdDatabase.readMyHouseholds(context);
  }

  @override
  Widget build(BuildContext context) {
    HouseholdNotifier householdNotifier = Provider.of<HouseholdNotifier>(context);

    if (householdNotifier.myHouseholds == null) {
      return Center(child: CircularProgressIndicator());
    } else if (householdNotifier.myHouseholds!.isEmpty) {
      return Center(child: Text('Empty'));
    } else if (householdNotifier.myHouseholds!.isNotEmpty) {
      return Center(child: Text('Has households'));
    } else {
      return Center(child: CircularProgressIndicator());
    }
  }
}
