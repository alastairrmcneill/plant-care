import 'package:flutter/material.dart';
import 'package:plant_care/features/home/households/screens/screens.dart';
import 'package:plant_care/features/home/households/widgets/widgets.dart';
import 'package:plant_care/general/models/models.dart';
import 'package:plant_care/general/notifiers/household_notifier.dart';
import 'package:plant_care/general/services/user_database.dart';
import 'package:provider/provider.dart';

class HouseholdListTile extends StatelessWidget {
  final Household household;
  HouseholdListTile({Key? key, required this.household}) : super(key: key);

  //  _buildUserPhotos(BuildContext context) {
  //   List<String?> photoUrls = [];
  //   for (var uid in household.members) {
  //     AppUser? appUser = await UserDatabase.readUser(context, uid: uid);
  //     if (appUser != null) {
  //       photoUrls.add(appUser.photoUrl);
  //     }
  //   }
  //   return PictureRow(photoUrls: photoUrls);
  // }

  Widget _buildPlantPhotos() {
    List<String?> photoUrls = [];
    if (household.plantsInfo.isNotEmpty) {
      household.plantsInfo.forEach((key, value) {
        Plant plant = Plant.fromJson(value);
        photoUrls.add(plant.photoURL);
      });
    }
    return PictureRow(photoUrls: photoUrls);
  }

  @override
  Widget build(BuildContext context) {
    HouseholdNotifier householdNotifier = Provider.of<HouseholdNotifier>(context);
    return GestureDetector(
      onTap: () {
        householdNotifier.setCurrentHousehold = household;
        Navigator.push(context, MaterialPageRoute(builder: (_) => const HouseholdDetailScreen()));
      },
      child: Container(
        decoration: const BoxDecoration(
          // color: Color.fromARGB(50, 0, 150, 135),
          color: Colors.teal,
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        padding: EdgeInsets.all(20),
        margin: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              household.name,
              style: Theme.of(context).textTheme.headline4!.copyWith(fontSize: 30, color: Colors.white),
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 15),
            Text(
              'Plants:',
              style: Theme.of(context).textTheme.caption!.copyWith(fontSize: 16, color: Colors.white),
            ),
            const SizedBox(height: 10),
            _buildPlantPhotos(),
          ],
        ),
      ),
    );
  }
}
