import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:plant_care/general/models/models.dart';
import 'package:plant_care/general/notifiers/notifiers.dart';
import 'package:provider/provider.dart';

class ProfilePhoto extends StatelessWidget {
  const ProfilePhoto({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserNotifier userNotifier = Provider.of<UserNotifier>(context, listen: false);
    AppUser user = userNotifier.currentUser!;
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
              backgroundImage: user.photoUrl != null ? CachedNetworkImageProvider(user.photoUrl!) : null,
              child: user.photoUrl == null
                  ? Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: AutoSizeText(
                          user.initials,
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
