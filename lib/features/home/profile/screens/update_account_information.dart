import 'package:flutter/material.dart';
import 'package:plant_care/features/home/profile/widgets/widgets.dart';

class UpdateAccountDetails extends StatelessWidget {
  const UpdateAccountDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update details'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            UpdateNameForm(),
            UpdatePasswordForm(),
          ],
        ),
      ),
    );
  }
}
