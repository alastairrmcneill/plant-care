import 'package:flutter/material.dart';
import 'package:plant_care/features/home/households/widgets/widgets.dart';

class PictureRow extends StatelessWidget {
  final List<String?> photoUrls;
  const PictureRow({Key? key, required this.photoUrls}) : super(key: key);

  Widget _buildRow(BuildContext context) {
    List<Container> circularPicutres = [];
    String text = '';
    int j = 0;

    for (var i = 0; i < photoUrls.length; i++) {
      double offset = j * 30;
      if (photoUrls[i] != null) {
        j++;
        circularPicutres.add(
          Container(
            margin: EdgeInsets.only(left: offset),
            child: CircularPicture(photoUrl: photoUrls[i]!),
          ),
        );
      }
    }
    circularPicutres.take(5);

    if (photoUrls.length > circularPicutres.length) {
      text = '+ more';
    }

    return Row(
      children: [
        Stack(
          children: [
            ...circularPicutres,
          ],
        ),
        const SizedBox(width: 5),
        Text(
          text,
          style: Theme.of(context).textTheme.caption!.copyWith(color: Colors.white70, fontSize: 15),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return photoUrls.isEmpty
        ? Text(
            'Empty',
            style: Theme.of(context).textTheme.caption!.copyWith(color: Colors.white70),
          )
        : _buildRow(context);
  }
}
