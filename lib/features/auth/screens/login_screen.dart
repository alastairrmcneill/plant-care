import 'package:flutter/material.dart';
import 'package:plant_care/features/auth/widgets/widgets.dart';
import 'package:plant_care/general/notifiers/notifiers.dart';
import 'package:plant_care/general/services/auth_service.dart';
import 'package:plant_care/general/widgets/widgets.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(height: 20),
              const LoginHeader(),
              const SizedBox(height: 40),
              Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    EmailFormField(textEditingController: _emailController),
                    const SizedBox(height: 10),
                    PasswordFormField(textEditingController: _passwordController),
                  ],
                ),
              ),
              const ForgotPasswordButton(),
              SignInButton(
                formKey: _formKey,
                emailController: _emailController,
                passwordController: _passwordController,
              ),
              const SizedBox(height: 30),
              const TextDivider(text: 'Or continue with'),
              const SizedBox(height: 30),
              const GoogleSignInButton(),
              const SizedBox(height: 5),
              const AppleSignInButton(),
              const RegisterNowButton(),
            ],
          ),
        ),
      ),
    );
  }
}
