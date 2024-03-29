import 'dart:io';

import 'package:flutter/material.dart';
import 'package:plant_care/general/services/auth_service.dart';

class RegisterButton extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final File? image;
  const RegisterButton({
    Key? key,
    required this.formKey,
    required this.nameController,
    required this.emailController,
    required this.passwordController,
    required this.image,
  }) : super(key: key);

  Future _register(BuildContext context) async {
    await AuthService.registerWithEmail(
      context,
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
      name: nameController.text.trim(),
      image: image,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 44,
      child: ElevatedButton(
        onPressed: () async {
          if (!formKey.currentState!.validate()) {
            return;
          }
          formKey.currentState!.save();
          await _register(context);
        },
        child: const Text('Register'),
      ),
    );
  }
}
