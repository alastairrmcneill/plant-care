import 'package:flutter/material.dart';
import 'package:plant_care/screens/plants/add_plant_screen.dart';

// 1 button Dialog
showAlertDialog(BuildContext context) {
  // set up the button
  Widget okButton = TextButton(
    child: Text("OK"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("My title"),
    content: Text("This is my message."),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

// 2 button Dialog

showHouseholdAddedDialog({required BuildContext context, required String title, required String message}) {
  // set up the buttons
  Widget buttonOne = TextButton(
    child: Text('Done'),
    onPressed: () {
      Navigator.of(context).pop();
      Navigator.of(context).pop();
    },
  );

  Widget buttonTwo = TextButton(
    child: Text('Add Plant'),
    onPressed: () {
      Navigator.of(context).pop();
      Navigator.of(context).pop();
      Navigator.push(context, MaterialPageRoute(builder: (_) => const AddPlant()));
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(title),
    content: Text(message),
    actionsAlignment: MainAxisAlignment.center,
    actions: [
      buttonOne,
      buttonTwo,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
