import 'package:flutter/material.dart';
import 'package:plant_care/features/auth/widgets/widgets.dart';
import 'package:plant_care/general/models/models.dart';
import 'package:plant_care/general/notifiers/notifiers.dart';
import 'package:provider/provider.dart';

class UpdatePasswordForm extends StatelessWidget {
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _password2Controller = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  UpdatePasswordForm({Key? key}) : super(key: key);

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
              child: PasswordFormField(textEditingController: _passwordController),
            ),
            ElevatedButton(
                onPressed: () async {
                  if (!_formKey.currentState!.validate()) {
                    return;
                  }
                  _formKey.currentState!.save();

                  // await UserService.updateUserName(context, user.copy(name: _nameController.text.trim()));
                },
                child: Text('Save new name'))
          ],
        ),
      ),
    );
  }
}
