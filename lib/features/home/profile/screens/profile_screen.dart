import 'package:flutter/material.dart';
import 'package:plant_care/general/models/models.dart';
import 'package:plant_care/general/notifiers/notifiers.dart';
import 'package:plant_care/general/services/auth_service.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserNotifier userNotifier = Provider.of<UserNotifier>(context, listen: false);
    AppUser user = userNotifier.currentUser!;

    return ListView(children: [
      CircleAvatar(
        radius: 80,
        backgroundColor: Colors.grey[300],
        backgroundImage: user.photoUrl != null ? NetworkImage(user.photoUrl!) : null,
        child: user.photoUrl == null ? const Icon(Icons.add_a_photo, size: 50) : null,
      ),
      ElevatedButton(onPressed: () => AuthService.signOut(), child: Text('Sign out'))
    ]);
  }
}
