import 'package:flutter/material.dart';
import 'package:plant_care/support/theme.dart';

class CustomToggleButton extends StatelessWidget {
  final bool selected;
  final String text;
  const CustomToggleButton({Key? key, required this.selected, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2),
      child: Container(
        width: 45,
        height: 30,
        decoration: BoxDecoration(
          color: selected ? Colors.teal : Colors.grey[200],
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(color: selected ? MyColors.appBackgroundColor : Colors.teal),
          ),
        ),
      ),
    );
  }
}
