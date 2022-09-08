import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CircularPicture extends StatelessWidget {
  final String photoUrl;
  const CircularPicture({Key? key, required this.photoUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 22,
      backgroundColor: Colors.white70,
      child: CircleAvatar(
        radius: 20,
        backgroundColor: Colors.grey[300],
        backgroundImage: CachedNetworkImageProvider(photoUrl),
      ),
    );
  }
}
