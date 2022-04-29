import 'package:flutter/material.dart';

class DetailSongPlayButton extends StatelessWidget {
  const DetailSongPlayButton({
    Key? key,
    this.appear,
  }) : super(key: key);

  final double? appear;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 250,
      right: 30,
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
