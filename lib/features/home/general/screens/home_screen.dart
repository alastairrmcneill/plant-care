import 'package:flutter/material.dart';
import 'package:plant_care/general/notifiers/notifiers.dart';
import 'package:plant_care/general/services/auth_service.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserNotifier userNotifier = Provider.of<UserNotifier>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
      ),
      body: Center(
        child: Column(
          children: [
            Text(userNotifier.currentUser!.uid!),
            ElevatedButton(
              onPressed: () async {
                await AuthService.signOut();
              },
              child: Text('Sign out'),
            ),
          ],
        ),
      ),
    );
  }
}
