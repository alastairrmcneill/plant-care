import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:plant_care/general/services/services.dart';

showCreateHouseholdDialog(BuildContext context, {required String body, required String hintText, required Function(String value) function}) {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? name;
  Dialog alert = Dialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
    child: Container(
      width: MediaQuery.of(context).size.width * 0.8,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.0)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          AutoSizeText(
            body,
            textAlign: TextAlign.center,
            maxLines: 4,
          ),
          const SizedBox(height: 10),
          Form(
            key: _formKey,
            child: TextFormField(
              decoration: InputDecoration(
                hintText: hintText,
              ),
              maxLines: 1,
              keyboardType: TextInputType.name,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Required';
                }
              },
              onSaved: (value) {
                name = value!.trim();
              },
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color?>(Colors.teal)),
              onPressed: () async {
                if (!_formKey.currentState!.validate()) {
                  return;
                }
                _formKey.currentState!.save();

                await function(name!);
                Navigator.of(context, rootNavigator: true).pop();
              },
              child: Text('OK'),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color?>(Colors.grey)),
              onPressed: () async {
                Navigator.of(context, rootNavigator: true).pop();
              },
              child: Text('Cancel'),
            ),
          ),
        ],
      ),
    ),
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
