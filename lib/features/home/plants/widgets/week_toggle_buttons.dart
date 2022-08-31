import 'package:flutter/material.dart';
import 'package:plant_care/features/home/plants/widgets/widgets.dart';

class WeekToggleButtons extends StatelessWidget {
  final List<bool> isSelected;
  final void Function(int index) onPressed;
  const WeekToggleButtons({Key? key, required this.isSelected, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: ToggleButtons(
        isSelected: isSelected,
        onPressed: (index) => onPressed(index),
        color: Colors.transparent,
        fillColor: Colors.transparent,
        hoverColor: Colors.transparent,
        borderColor: Colors.transparent,
        splashColor: Colors.transparent,
        disabledColor: Colors.transparent,
        selectedColor: Colors.transparent,
        highlightColor: Colors.transparent,
        disabledBorderColor: Colors.transparent,
        selectedBorderColor: Colors.transparent,
        focusColor: Colors.transparent,
        children: [
          CustomToggleButton(selected: isSelected[0], text: 'Mon'),
          CustomToggleButton(selected: isSelected[1], text: 'Tue'),
          CustomToggleButton(selected: isSelected[2], text: 'Wed'),
          CustomToggleButton(selected: isSelected[3], text: 'Thu'),
          CustomToggleButton(selected: isSelected[4], text: 'Fri'),
          CustomToggleButton(selected: isSelected[5], text: 'Sat'),
          CustomToggleButton(selected: isSelected[6], text: 'Sun'),
        ],
      ),
    );
  }
}
