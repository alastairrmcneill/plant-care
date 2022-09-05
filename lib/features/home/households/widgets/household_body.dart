import 'package:flutter/material.dart';
import 'package:plant_care/features/home/households/widgets/widgets.dart';
import 'package:plant_care/general/notifiers/notifiers.dart';
import 'package:plant_care/general/services/services.dart';
import 'package:provider/provider.dart';

class HouseholdBody extends StatefulWidget {
  const HouseholdBody({Key? key}) : super(key: key);

  @override
  State<HouseholdBody> createState() => _HouseholdBodyState();
}

class _HouseholdBodyState extends State<HouseholdBody> {
  @override
  void initState() {
    super.initState();
    _refresh();
  }

  Future _refresh() async {
    HouseholdDatabase.readMyHouseholds(context);
  }

  Widget _buildBody() {
    HouseholdNotifier householdNotifier = Provider.of<HouseholdNotifier>(context);
    if (householdNotifier.myHouseholds == null) {
      return const Center(child: CircularProgressIndicator());
    } else if (householdNotifier.myHouseholds!.isEmpty) {
      return const Center(child: Text('Empty'));
    } else if (householdNotifier.myHouseholds!.isNotEmpty) {
      return const HouseholdListView();
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
