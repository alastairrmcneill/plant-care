import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:plant_care/features/home/households/widgets/widgets.dart';
import 'package:plant_care/general/notifiers/user_notifier.dart';
import 'package:plant_care/general/services/services.dart';
import 'package:provider/provider.dart';

class HouseholdsScreen extends StatelessWidget {
  const HouseholdsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // UserNotifier userNotifier = Provider.of<UserNotifier>(context);

    return Scaffold(
        // appBar: AppBar(
        //   systemOverlayStyle: const SystemUiOverlayStyle(
        //     statusBarColor: Colors.transparent, // <-- SEE HERE
        //     statusBarIconBrightness: Brightness.dark, //<-- For Android SEE HERE (dark icons)
        //     statusBarBrightness: Brightness.light, //<-- For iOS SEE HERE (dark icons)
        //   ),
        //   title: Column(
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     children: [
        //       Text(
        //         'Hello ${userNotifier.currentUser?.name.split(' ')[0]}! 👋',
        //         style: const TextStyle(fontWeight: FontWeight.w400),
        //       ),
        //       const Text(
        //         'Your households:',
        //         style: TextStyle(fontWeight: FontWeight.w200, fontSize: 16),
        //       ),
        //     ],
        //   ),
        //   centerTitle: false,
        //   backgroundColor: Colors.transparent,
        //   foregroundColor: Colors.black,
        //   shadowColor: Colors.transparent,
        // ),
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
                  HouseholdService.addCurrentUserToHousehold(context, code: code);
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
        body: const SafeArea(child: HouseholdBody()));
  }
}
