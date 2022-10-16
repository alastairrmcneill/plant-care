import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:plant_care/general/models/models.dart';

class TaskTile extends StatelessWidget {
  final Event event;
  const TaskTile({Key? key, required this.event}) : super(key: key);

  String _buildDueString() {
    String dueString = '';
    DateTime now = DateTime.now();
    now = DateTime(now.year, now.month, now.day);

    if (event.nextAction.isAtSameMomentAs(now)) {
      dueString = 'Due today';
    } else if (event.nextAction.isBefore(now)) {
      dueString = 'Overdue';
    } else if (event.nextAction.isAfter(now)) {
      int daysUntil = event.nextAction.difference(now).inDays;
      if (daysUntil == 1) {
        dueString = 'Due in 1 day';
      } else {
        dueString = 'Due in $daysUntil days';
      }
    }

    return dueString;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: eventColors[event.type],
          borderRadius: BorderRadius.circular(10),
        ),
        width: double.infinity,
        child: ExpandablePanel(
          theme: const ExpandableThemeData(headerAlignment: ExpandablePanelHeaderAlignment.center),
          header: Row(
            children: [
              Icon(eventIcons[event.type]),
              const SizedBox(width: 15),
              Text(event.type),
            ],
          ),
          collapsed: const SizedBox(),
          expanded: Padding(
            padding: const EdgeInsets.all(8.0).copyWith(top: 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(_buildDueString()),
                event.notes != "" ? Text('Note: ${event.notes}') : const SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
