import 'package:flutter/material.dart';
import 'package:plant_care/general/services/auth_service.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            await AuthService.loginWithGoogle();
          },
          child: Text('Sign in with google'),
        ),
      ),
    );
  }
}
