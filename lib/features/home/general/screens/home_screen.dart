import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:plant_care/features/home/calendar/screens/screens.dart';
import 'package:plant_care/features/home/households/screens/screens.dart';
import 'package:plant_care/features/home/plants/screens/screens.dart';
import 'package:plant_care/features/home/profile/screens/screens.dart';

import 'package:plant_care/general/services/services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<NavigatorState> firstTabNavKey = GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> secondTabNavKey = GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> thirdTabNavKey = GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> fourthTabNavKey = GlobalKey<NavigatorState>();
  CupertinoTabController _tabController = CupertinoTabController();
  int _currentIndex = 0;
  List<Widget> screens = [
    PlantsScreen(),
    HouseholdsScreen(),
    CalendarScreen(),
    ProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future _loadData() async {
    await UserDatabase.readCurrentUser(context);
    await HouseholdDatabase.readMyHouseholds(context);
    await EventDatabase.readMyEvents(context);
  }

  GlobalKey<NavigatorState>? currentNavigatorKey() {
    switch (_tabController.index) {
      case 0:
        return firstTabNavKey;
        break;
      case 1:
        return secondTabNavKey;
        break;
      case 2:
        return thirdTabNavKey;
        break;
      case 3:
        return fourthTabNavKey;
        break;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return !await currentNavigatorKey()!.currentState!.maybePop();
      },
      child: CupertinoTabScaffold(
        controller: _tabController,
        tabBar: CupertinoTabBar(
          backgroundColor: Colors.white,
          activeColor: Colors.teal,
          inactiveColor: Colors.grey[300]!,
          height: 60,
          iconSize: 22,
          border: Border.all(color: Colors.transparent),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.seedling),
              label: 'Plants',
            ),
            BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.house),
              label: 'Households',
            ),
            BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.calendarDays),
              label: 'Calendar',
            ),
            BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.solidUser),
              label: 'Profile',
            ),
          ],
        ),
        tabBuilder: ((context, index) {
          switch (index) {
            case 0:
              return CupertinoTabView(
                  navigatorKey: firstTabNavKey,
                  builder: (context) {
                    return CupertinoPageScaffold(
                      child: PlantsScreen(),
                    );
                  });
            case 1:
              return CupertinoTabView(
                  navigatorKey: secondTabNavKey,
                  builder: (context) {
                    return CupertinoPageScaffold(
                      child: HouseholdsScreen(),
                    );
                  });
            case 2:
              return CupertinoTabView(
                  navigatorKey: thirdTabNavKey,
                  builder: (context) {
                    return CupertinoPageScaffold(
                      child: CalendarScreen(),
                    );
                  });
            case 3:
              return CupertinoTabView(
                  navigatorKey: fourthTabNavKey,
                  builder: (context) {
                    return CupertinoPageScaffold(
                      child: ProfileScreen(),
                    );
                  });
            default:
              return CupertinoTabView(
                  navigatorKey: firstTabNavKey,
                  builder: (context) {
                    return CupertinoPageScaffold(
                      child: PlantsScreen(),
                    );
                  });
          }
        }),
      ),
    );
  }
}
