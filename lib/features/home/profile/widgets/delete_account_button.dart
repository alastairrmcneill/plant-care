import 'package:flutter/material.dart';
import 'package:plant_care/general/services/services.dart';
import 'package:plant_care/general/widgets/widgets.dart';

class DeleteAccountButton extends StatelessWidget {
  const DeleteAccountButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SizedBox(
          width: double.infinity,
          child: TextButton(
              onPressed: () => showTwoButtonDialog(
                    context,
                    'Are you sure you want to delete your account?',
                    'OK',
                    () async {
                      await AuthService.delete(context);
                    },
                    'Cancel',
                    () {},
                  ),
              child: Text('Delete Account'))),
    );
  }
}
