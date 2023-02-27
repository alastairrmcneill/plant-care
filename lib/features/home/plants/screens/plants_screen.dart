import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:plant_care/features/home/plants/screens/screens.dart';
import 'package:plant_care/features/home/plants/widgets/widgets.dart';
import 'package:plant_care/general/notifiers/notifiers.dart';
import 'package:plant_care/general/services/auth_service.dart';
import 'package:provider/provider.dart';

class PlantsScreen extends StatelessWidget {
  const PlantsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserNotifier userNotifier = Provider.of<UserNotifier>(context);

    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent, // <-- SEE HERE
          statusBarIconBrightness: Brightness.dark, //<-- For Android SEE HERE (dark icons)
          statusBarBrightness: Brightness.light, //<-- For iOS SEE HERE (dark icons)
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hello ${userNotifier.currentUser?.name.split(' ')[0] ?? ""}! 👋',
              style: const TextStyle(fontWeight: FontWeight.w400),
            ),
            const Text(
              'Your plants:',
              style: TextStyle(fontWeight: FontWeight.w200, fontSize: 16),
            ),
          ],
        ),
        centerTitle: false,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        shadowColor: Colors.transparent,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const CreatePlantScreen())),
        child: const Icon(Icons.add),
      ),
      body: const SafeArea(child: PlantBody()),
    );
  }
}
