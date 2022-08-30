import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:plant_care/features/home/calendar/screens/screens.dart';
import 'package:plant_care/features/home/households/screens/screens.dart';
import 'package:plant_care/features/home/plants/screens/screens.dart';
import 'package:plant_care/features/home/profile/screens/screens.dart';
import 'package:plant_care/general/services/user_database.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
    UserDatabase.readCurrentUser(context);
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        backgroundColor: Colors.teal,
        activeColor: Theme.of(context).scaffoldBackgroundColor,
        inactiveColor: Colors.white54,
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
            return CupertinoTabView(builder: (context) {
              return CupertinoPageScaffold(child: PlantsScreen());
            });
          case 1:
            return CupertinoTabView(builder: (context) {
              return CupertinoPageScaffold(child: HouseholdsScreen());
            });
          case 2:
            return CupertinoTabView(builder: (context) {
              return CupertinoPageScaffold(child: CalendarScreen());
            });
          case 3:
            return CupertinoTabView(builder: (context) {
              return CupertinoPageScaffold(child: ProfileScreen());
            });
          default:
            return CupertinoTabView(builder: (context) {
              return CupertinoPageScaffold(child: PlantsScreen());
            });
        }
      }),
    );
  }
}
