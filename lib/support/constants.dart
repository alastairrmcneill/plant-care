import 'package:flutter/material.dart';
import 'package:plant_care/general/models/event_model.dart';

enum MenuItems {
  item1,
  item2,
  item3;
}

Map<String, Color> eventColors = {
  EventTypes.water: Color.fromARGB(255, 118, 179, 245),
  EventTypes.mist: Color.fromARGB(255, 213, 131, 227),
  EventTypes.feed: Color.fromARGB(255, 132, 187, 135),
};
