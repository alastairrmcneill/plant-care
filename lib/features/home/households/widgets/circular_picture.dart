import 'dart:ffi';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CircularPicture extends StatelessWidget {
  final String? photoUrl;
  final String text;
  final double radius;
  const CircularPicture({Key? key, this.photoUrl, required this.text, required this.radius}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: Colors.white,
      child: CircleAvatar(
        radius: radius / 1.1,
        backgroundColor: Colors.grey[300],
        backgroundImage: photoUrl != null ? CachedNetworkImageProvider(photoUrl!) : null,
        child: photoUrl != null
            ? null
            : Center(
                child: Text(
                  text,
                  style: TextStyle(color: Colors.grey[700], fontSize: radius * 0.6),
                  maxLines: 1,
                  textAlign: TextAlign.center,
                ),
              ),
      ),
    );
  }
}
