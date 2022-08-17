import 'package:flutter/material.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 190,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CircleAvatar(
            radius: 50,
            backgroundColor: Colors.transparent,
            child: Image.asset('assets/images/plant_logo.png'),
          ),
          Text(
            'Welcome to Plant Care!',
            style: Theme.of(context).textTheme.headline5,
          ),
          Text(
            'Please enter your details',
            style: Theme.of(context).textTheme.subtitle1,
          ),
        ],
      ),
    );
  }
}
