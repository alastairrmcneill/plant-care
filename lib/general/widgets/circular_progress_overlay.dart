import 'package:flutter/material.dart';

showCircularProgressOverlay(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => const Center(child: CircularProgressIndicator()),
  );
}

stopCircularProgressOverlay(BuildContext context) {
  Navigator.of(context).popUntil((route) => route.isFirst);
}
