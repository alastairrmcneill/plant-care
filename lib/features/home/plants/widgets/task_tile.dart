import 'package:auto_size_text/auto_size_text.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:plant_care/features/home/plants/widgets/widgets.dart';
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
          header: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Row(
              children: [
                // Icon
                SizedBox(
                  width: 30,
                  child: eventIcons[event.type]!,
                ),
                const SizedBox(width: 10),
                // Name and type
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AutoSizeText(
                        event.type,
                        maxLines: 1,
                        maxFontSize: 25,
                        minFontSize: 16,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: eventAccentColors[event.type], fontWeight: FontWeight.w300, fontSize: 25),
                      ),
                      Text(
                        _buildDueString(),
                        style: TextStyle(color: eventAccentColors[event.type], fontWeight: FontWeight.w300, fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          collapsed: const SizedBox(),
          expanded: Padding(
            padding: const EdgeInsets.all(8.0).copyWith(top: 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Divider(),
                Text('Days',
                    style: TextStyle(
                      color: eventAccentColors[event.type],
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    )),
                DaysRow(
                  days: event.days,
                  color: eventAccentColors[event.type]!,
                ),
                Text('Repeats every ${event.repeats}'),
                event.notes != ""
                    ? Text(
                        'Note:',
                        style: TextStyle(
                          color: eventAccentColors[event.type],
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      )
                    : const SizedBox(),
                event.notes != ""
                    ? Text(event.notes,
                        style: TextStyle(
                          color: eventAccentColors[event.type],
                          fontWeight: FontWeight.w300,
                          fontSize: 14,
                        ))
                    : const SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
