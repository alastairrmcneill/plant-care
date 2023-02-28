import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:plant_care/features/home/profile/screens/screens.dart';
import 'package:plant_care/features/home/profile/widgets/widgets.dart';
import 'package:plant_care/general/models/models.dart';
import 'package:plant_care/general/notifiers/notifiers.dart';
import 'package:plant_care/general/services/auth_service.dart';
import 'package:plant_care/general/widgets/widgets.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    UserNotifier userNotifier = Provider.of<UserNotifier>(context);
    SettingsNotifier settingsNotifier = Provider.of<SettingsNotifier>(context);
    AppUser? user = userNotifier.currentUser;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              user != null ? CircularHeaderImage(photoURL: user.photoUrl, initials: user.initials) : const SizedBox(),
              const SizedBox(height: 10),
              AutoSizeText(
                user?.name ?? "User",
                maxLines: 1,
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 10),
              Divider(),
              // ListTile(
              //   title: Text('Account Details'),
              //   trailing: Icon(Icons.chevron_right_rounded),
              //   onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => UpdateAccountDetails())),
              // ),
              // ListTile(
              //   title: const Text('Dark Mode'),
              //   trailing: Switch(
              //     value: settingsNotifier.darkMode,
              //     onChanged: (value) {
              //       setState(() {
              //         settingsNotifier.setDarkMode(value);
              //       });
              //     },
              //   ),
              // ),
              const SizedBox(height: 10),
              const SignOutButton(),
              const DeleteAccountButton(),
            ],
          ),
        ),
      ),
    );
  }
}
