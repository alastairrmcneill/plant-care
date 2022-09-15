import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CircularPicture extends StatelessWidget {
  final String? photoUrl;
  final String text;
  const CircularPicture({Key? key, this.photoUrl, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 18,
      backgroundColor: Colors.white,
      child: CircleAvatar(
          radius: 16,
          backgroundColor: Colors.grey[300],
          backgroundImage: photoUrl != null ? CachedNetworkImageProvider(photoUrl!) : null,
          child: photoUrl != null
              ? null
              : Center(
                  child: Text(
                    text,
                    style: TextStyle(color: Colors.grey[700], fontSize: 14),
                    maxLines: 1,
                    textAlign: TextAlign.center,
                  ),
                )),
    );
  }
}
