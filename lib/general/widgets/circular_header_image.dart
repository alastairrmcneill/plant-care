import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:plant_care/general/widgets/widgets.dart';

class CircularHeaderImage extends StatelessWidget {
  final String? photoURL;
  final String initials;
  const CircularHeaderImage({Key? key, required this.photoURL, required this.initials}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (photoURL != null) {
          Navigator.push(context, MaterialPageRoute(builder: (_) => FullScreenImage(photoURL: photoURL!)));
        }
      },
      child: Card(
        elevation: 2,
        shape: const CircleBorder(),
        child: CircleAvatar(
          radius: 80,
          backgroundColor: Colors.white,
          child: CircleAvatar(
            radius: 76,
            backgroundColor: Colors.grey[400],
            backgroundImage: photoURL != null ? CachedNetworkImageProvider(photoURL!) : null,
            child: photoURL != null
                ? null
                : Text(
                    initials,
                    style: TextStyle(fontSize: 20, color: Colors.grey[700]),
                  ),
          ),
        ),
      ),
    );
  }
}
