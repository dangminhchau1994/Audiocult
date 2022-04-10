import 'package:audio_cult/w_components/images/common_image_network.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../utils/constants/app_colors.dart';

class DetailPhotoSong extends StatelessWidget {
  const DetailPhotoSong({
    Key? key,
    this.imagePath,
  }) : super(key: key);

  final String? imagePath;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 30),
      width: MediaQuery.of(context).size.width,
      height: 300,
      child: CommonImageNetWork(
        width: double.infinity,
        height: 300,
        imagePath: imagePath ?? '',
      ),
    );
  }
}
