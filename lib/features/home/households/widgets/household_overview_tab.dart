import 'package:flutter/material.dart';
import 'package:plant_care/features/home/households/widgets/widgets.dart';
import 'package:plant_care/features/home/plants/widgets/widgets.dart';
import 'package:plant_care/general/models/models.dart';
import 'package:plant_care/general/notifiers/household_notifier.dart';
import 'package:plant_care/general/notifiers/notifiers.dart';
import 'package:provider/provider.dart';

class HouseholdOverviewTab extends StatelessWidget {
  const HouseholdOverviewTab({Key? key}) : super(key: key);

  List<AppUser> getMembers(BuildContext context) {
    HouseholdNotifier householdNotifier = Provider.of<HouseholdNotifier>(context, listen: false);
    Household household = householdNotifier.currentHousehold!;
    List<AppUser> members = [];

    for (var uid in household.members) {
      AppUser? appUser = householdNotifier.myHouseholdsMembers[uid];
      if (appUser != null) {
        members.add(appUser);
      }
    }

    return members;
  }

  List<Widget> buildPlants(Household household) {
    if (household.plantsInfo.isEmpty) {
      return [
        const Padding(
          padding: EdgeInsets.only(top: 100),
          child: Text(
            'Go to the plants tab and press the + button to get started with your first plant!',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w200,
              fontSize: 24,
            ),
          ),
        )
      ];
    }
    return household.plantsInfo.values.toList().map((value) => PlantListTile(plant: Plant.fromJson(value))).toList();
  }

  @override
  Widget build(BuildContext context) {
    HouseholdNotifier householdNotifier = Provider.of<HouseholdNotifier>(context);
    Household household = householdNotifier.currentHousehold!;
    List<AppUser> members = getMembers(context);
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Members',
                  style: TextStyle(fontWeight: FontWeight.w300, fontSize: 16),
                ),
                SizedBox(
                  height: 100,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    physics: const ClampingScrollPhysics(),
                    children: members.map((member) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: CircularPicture(
                          photoUrl: member.photoUrl,
                          text: member.initials,
                          radius: 40,
                        ),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Plants',
                  style: TextStyle(fontWeight: FontWeight.w300, fontSize: 16),
                ),
              ],
            ),
          ),
          ...buildPlants(household),
        ],
      ),
    );
  }
}
