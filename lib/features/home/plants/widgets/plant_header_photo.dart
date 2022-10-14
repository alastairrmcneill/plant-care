import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class PlantHeaderPhoto extends StatelessWidget {
  final String? photoURL;
  final String initials;
  const PlantHeaderPhoto({Key? key, required this.photoURL, required this.initials}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(width: MediaQuery.of(context).size.width * 0.3),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.3,
          child: FittedBox(
            fit: BoxFit.cover,
            child: CircleAvatar(
              radius: 80,
              backgroundColor: Colors.grey[300],
              backgroundImage: photoURL != null ? CachedNetworkImageProvider(photoURL!) : null,
              child: photoURL == null
                  ? Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: AutoSizeText(
                          initials,
                          style: TextStyle(color: Colors.grey[700], fontSize: 80),
                          maxLines: 1,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )
                  : null,
            ),
          ),
        ),
        SizedBox(width: MediaQuery.of(context).size.width * 0.3),
      ],
    );
  }
}
