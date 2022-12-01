import 'package:flutter/material.dart';
import 'package:plant_care/features/auth/widgets/widgets.dart';
import 'package:plant_care/general/models/models.dart';
import 'package:plant_care/general/notifiers/notifiers.dart';
import 'package:plant_care/general/services/user_database.dart';
import 'package:plant_care/general/services/user_service.dart';
import 'package:provider/provider.dart';

class UpdateNameForm extends StatelessWidget {
  TextEditingController _nameController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  UpdateNameForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserNotifier userNotifier = Provider.of<UserNotifier>(context, listen: false);
    AppUser user = userNotifier.currentUser!;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 8),
      child: Container(
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: NameFormField(textEditingController: _nameController),
            ),
            ElevatedButton(
                onPressed: () async {
                  if (!_formKey.currentState!.validate()) {
                    return;
                  }
                  _formKey.currentState!.save();

                  await UserService.updateUserName(context, user.copy(name: _nameController.text.trim()));
                },
                child: Text('Save new name'))
          ],
        ),
      ),
    );
  }
}
