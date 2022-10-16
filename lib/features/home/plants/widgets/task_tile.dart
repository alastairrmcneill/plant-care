import 'package:flutter/material.dart';
import 'package:plant_care/general/models/models.dart';
import 'package:plant_care/support/constants.dart';

class TaskTile extends StatelessWidget {
  final Event event;
  const TaskTile({Key? key, required this.event}) : super(key: key);

  Widget _buildTile() {
    if (event.notes == '') {
      return Text(event.type);
    } else {
      return ExpansionTile(
        title: Text(event.type),
        children: [
          Text(event.notes),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15),
      child: Container(
        width: double.infinity,
        height: 100,
        color: eventColors[event.type],
        child: _buildTile(),
      ),
    );
  }
}
