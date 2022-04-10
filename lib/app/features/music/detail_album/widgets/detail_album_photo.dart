import 'package:audio_cult/w_components/images/common_image_network.dart';
import 'package:flutter/material.dart';

class DetailAlbumPhoto extends StatelessWidget {
  const DetailAlbumPhoto({
    Key? key,
    this.imagePath,
  }) : super(key: key);

  final String? imagePath;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 300,
      margin: const EdgeInsets.only(bottom: 30),
      child: CommonImageNetWork(
        width: double.infinity,
        imagePath: imagePath ?? '',
      ),
    );
  }
}
