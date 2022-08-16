import 'package:flutter/material.dart';

class OnboardingPage extends StatelessWidget {
  final String message;
  OnboardingPage({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(message),
      ),
    );
  }
}
