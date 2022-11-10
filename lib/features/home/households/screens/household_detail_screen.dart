import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:plant_care/features/home/households/widgets/widgets.dart';
import 'package:plant_care/general/models/models.dart';
import 'package:plant_care/general/notifiers/notifiers.dart';
import 'package:plant_care/general/services/services.dart';
import 'package:plant_care/general/widgets/widgets.dart';
import 'package:plant_care/support/constants.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class HouseholdDetailScreen extends StatefulWidget {
  const HouseholdDetailScreen({Key? key}) : super(key: key);

  @override
  State<HouseholdDetailScreen> createState() => _HouseholdDetailScreenState();
}

class _HouseholdDetailScreenState extends State<HouseholdDetailScreen> with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    HouseholdNotifier householdNotifier = Provider.of<HouseholdNotifier>(context);
    EventNotifier eventNotifier = Provider.of<EventNotifier>(context);
    Household household = householdNotifier.currentHousehold!;

    return Scaffold(
      appBar: AppBar(
        title: Text(household.name),
        actions: [
          PopupMenuButton(
            icon: const Icon(Icons.more_vert_rounded),
            onSelected: (value) async {
              if (value == MenuItems.item1) {
                showTwoButtonDialog(
                  context,
                  "Share this code: ${household.code}",
                  'Copy',
                  () async {
                    Clipboard.setData(ClipboardData(text: household.code));
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          "Household code copied to clipboard",
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                  },
                  'Cancel',
                  () {},
                );
              } else if (value == MenuItems.item2) {
                await HouseholdService.editHousehold(context, household: household);
              } else if (value == MenuItems.item3) {
                await HouseholdService.removeCurrentUser(context, household: household);
              }
            },
            itemBuilder: (context) => const [
              PopupMenuItem(
                value: MenuItems.item1,
                child: Text('Share'),
              ),
              PopupMenuItem(
                value: MenuItems.item2,
                child: Text('Edit'),
              ),
              PopupMenuItem(
                value: MenuItems.item3,
                child: Text('Leave'),
              ),
            ],
          ),
        ],
        elevation: 0,
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(25.0),
            ),
            height: 32,
            child: TabBar(
              controller: tabController,
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(25.0),
                color: Theme.of(context).primaryColor,
              ),
              labelColor: Colors.white,
              unselectedLabelColor: Colors.black,
              labelStyle: TextStyle(color: Colors.grey[800], fontWeight: FontWeight.w300, fontSize: 14),
              tabs: const [
                Tab(
                  text: 'Overview',
                ),
                Tab(text: 'Schedule'),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: const [
                HouseholdOverviewTab(),
                HouseholdCalendarTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
