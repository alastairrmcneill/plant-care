import 'package:flutter/material.dart';
import 'package:plant_care/features/home/households/screens/screens.dart';
import 'package:plant_care/features/home/households/widgets/widgets.dart';
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
        decoration: const BoxDecoration(
          color: Color.fromARGB(50, 0, 150, 135),
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
              style: Theme.of(context).textTheme.headline4!.copyWith(fontSize: 30),
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 10),
            Text(
              'Household members:',
              style: Theme.of(context).textTheme.caption!.copyWith(fontSize: 16),
            ),
            PictureRow(photoUrls: ['', '']),
            const SizedBox(height: 15),
            Text(
              'Plants:',
              style: Theme.of(context).textTheme.caption!.copyWith(fontSize: 16),
            ),
            PictureRow(photoUrls: ['', '', '', '']),
          ],
        ),
      ),
    );
  }
}
