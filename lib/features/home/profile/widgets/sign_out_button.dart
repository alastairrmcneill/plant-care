import 'package:flutter/material.dart';
import 'package:plant_care/general/services/services.dart';
import 'package:plant_care/general/widgets/widgets.dart';

class SignOutButton extends StatelessWidget {
  const SignOutButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
              onPressed: () => showTwoButtonDialog(
                    context,
                    'Do you want to sign out?',
                    'OK',
                    () async {
                      await AuthService.signOut(context);
                    },
                    'Cancel',
                    () {},
                  ),
              child: Text('Sign out'))),
    );
  }
}
