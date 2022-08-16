import 'package:flutter/material.dart';
import 'package:plant_care/general/services/auth_service.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            await AuthService.signOut();
          },
          child: Text('Sign out'),
        ),
      ),
    );
  }
}
