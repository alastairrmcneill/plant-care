import 'package:flutter/material.dart';

class PictureRow extends StatelessWidget {
  final List<String> photoUrls;
  const PictureRow({Key? key, required this.photoUrls}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: photoUrls
          .map(
            (user) => CircleAvatar(),
          )
          .toList(),
    );
  }
}
