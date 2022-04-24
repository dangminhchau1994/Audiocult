import 'package:audio_cult/w_components/loading/loading_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../app/utils/constants/app_colors.dart';

class CommonImageNetWork extends StatelessWidget {
  const CommonImageNetWork({
    Key? key,
    this.imagePath,
    this.width = 50,
    this.height = 50,
  }) : super(key: key);

  final double? width;
  final double? height;
  final String? imagePath;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      width: width,
      height: height,
      imageUrl: imagePath ?? '',
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover,
          ),
        ),
      ),
      placeholder: (context, url) => Center(
          child: Container(
        alignment: Alignment.center,
        constraints: const BoxConstraints(minHeight: 50),
        child: const LoadingWidget(),
      )),
      errorWidget: (
        BuildContext context,
        _,
        __,
      ) =>
          const Image(
        fit: BoxFit.cover,
        image: AssetImage(
          'assets/cover.jpg',
        ),
      ),
    );
  }
}
