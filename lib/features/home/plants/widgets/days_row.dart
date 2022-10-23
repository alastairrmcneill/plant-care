import 'package:flutter/material.dart';
import 'package:plant_care/support/theme.dart';

class DaysRow extends StatelessWidget {
  final List<bool> days;
  final Color color;
  const DaysRow({Key? key, required this.days, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Tile(selected: days[0], text: 'Mon', color: color),
        Tile(selected: days[1], text: 'Tue', color: color),
        Tile(selected: days[2], text: 'Wed', color: color),
        Tile(selected: days[3], text: 'Thu', color: color),
        Tile(selected: days[4], text: 'Fri', color: color),
        Tile(selected: days[5], text: 'Sat', color: color),
        Tile(selected: days[6], text: 'Sun', color: color),
      ],
    );
  }
}

class Tile extends StatelessWidget {
  final bool selected;
  final String text;
  final Color color;
  const Tile({Key? key, required this.selected, required this.text, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(2),
        child: Container(
          height: 30,
          decoration: BoxDecoration(
            color: selected ? color : Colors.grey[200],
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(color: selected ? MyColors.appBackgroundColor : color),
            ),
          ),
        ),
      ),
    );
  }
}
