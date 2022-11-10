import 'package:flutter/material.dart';
import 'package:plant_care/features/home/households/widgets/widgets.dart';
import 'package:plant_care/general/models/models.dart';
import 'package:plant_care/general/notifiers/household_notifier.dart';
import 'package:provider/provider.dart';

class HouseholdMembersPhotosRow extends StatelessWidget {
  final Household household;
  const HouseholdMembersPhotosRow({Key? key, required this.household}) : super(key: key);

  List<AppUser> getMembers(BuildContext context) {
    HouseholdNotifier householdNotifier = Provider.of<HouseholdNotifier>(context, listen: false);
    List<AppUser> members = [];

    for (var uid in household.members) {
      AppUser? appUser = householdNotifier.myHouseholdsMembers[uid];
      if (appUser != null) {
        members.add(appUser);
      }
    }

    return members;
  }

  @override
  Widget build(BuildContext context) {
    List<AppUser> members = getMembers(context);
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const ClampingScrollPhysics(),
      child: Stack(
        children: members.asMap().entries.map((value) {
          int index = value.key;
          AppUser member = value.value;
          double offset = index * 25;
          return Padding(
            padding: EdgeInsets.only(left: offset),
            child: CircularPicture(
              photoUrl: member.photoUrl,
              text: member.initials,
              radius: 18,
            ),
          );
        }).toList(),
      ),
    );
  }
}
