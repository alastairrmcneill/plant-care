import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:plant_care/general/services/services.dart';

class GoogleSignInButton extends StatelessWidget {
  const GoogleSignInButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 44,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
          foregroundColor: MaterialStateProperty.all<Color>(Colors.grey[800]!),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
              side: BorderSide(color: Colors.grey[800]!),
            ),
          ),
        ),
        onPressed: () async {
          await AuthService.loginWithGoogle(context);
        },
        child: Stack(
          children: const [
            Align(alignment: Alignment(-0.95, 0), child: Icon(FontAwesomeIcons.google, color: Colors.red)),
            Align(alignment: Alignment.center, child: Text('Sign in with Google')),
          ],
        ),
      ),
    );
  }
}
