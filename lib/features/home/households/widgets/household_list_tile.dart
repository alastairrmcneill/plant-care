import 'package:flutter/material.dart';
import 'package:plant_care/features/home/households/screens/screens.dart';
import 'package:plant_care/features/home/households/widgets/widgets.dart';
import 'package:plant_care/general/models/models.dart';
import 'package:plant_care/general/notifiers/notifiers.dart';
import 'package:plant_care/general/services/services.dart';
import 'package:provider/provider.dart';

class HouseholdListTile extends StatelessWidget {
  final Household household;
  HouseholdListTile({Key? key, required this.household}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HouseholdNotifier householdNotifier = Provider.of<HouseholdNotifier>(context);
    return GestureDetector(
      onTap: () {
        householdNotifier.setCurrentHousehold = household;
        EventService.getCurrentHouseholdEvents(context);
        Navigator.push(context, MaterialPageRoute(builder: (_) => const HouseholdDetailScreen()));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Container(
            padding: const EdgeInsets.all(10),
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF15CAB8), Color(0xFF109C8E)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  household.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Divider(color: Colors.white, thickness: 1),
                const Text(
                  'Household members:',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                HouseholdMembersPhotosRow(household: household),
                const SizedBox(height: 10),
                const Text(
                  'Plants:',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                PlantsPhotoRow(household: household),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
