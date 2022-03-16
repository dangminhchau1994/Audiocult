import 'package:flutter/material.dart';

class DetailAlbumPlayButton extends StatelessWidget {
  const DetailAlbumPlayButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PositionedDirectional(
      top: 276,
      end: 30,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
        child: const Icon(
          Icons.play_arrow,
          color: Colors.black,
        ),
      ),
    );
  }
}
