import 'package:flutter/material.dart';

class PlantNameFormField extends StatelessWidget {
  final TextEditingController textEditingController;
  const PlantNameFormField({Key? key, required this.textEditingController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditingController,
      decoration: const InputDecoration(
        hintText: 'Plant name',
      ),
      maxLines: 1,
      textCapitalization: TextCapitalization.words,
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Required';
        }
      },
      onSaved: (value) {
        textEditingController.text = value!;
      },
    );
  }
}
