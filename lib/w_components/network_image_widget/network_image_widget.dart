import 'package:audio_cult/app/utils/constants/app_assets.dart';
import 'package:audio_cult/app/utils/constants/app_colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class NetworkImageWidget extends StatelessWidget {
  final String imagePath;
  final Widget? child;
  final BorderRadius? borderRadius;

  const NetworkImageWidget(
    this.imagePath, {
    this.child,
    this.borderRadius,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      placeholder: (_, __) => Center(
        child: CircularProgressIndicator(
          color: AppColors.primaryButtonColor,
        ),
      ),
      errorWidget: (_, __, ___) => _bgImageWidget(child: child),
      width: double.infinity,
      height: 220,
      imageUrl: imagePath,
      imageBuilder: (_, imageProvider) => _bgImageWidget(child: child, image: imageProvider),
    );
  }

  Widget _bgImageWidget({Widget? child, ImageProvider? image}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: borderRadius ?? const BorderRadius.all(Radius.circular(4)),
        image: DecorationImage(
          image: image ?? const ExactAssetImage(AppAssets.imgHeaderDrawer),
          fit: BoxFit.cover,
        ),
      ),
      child: child,
    );
  }
}
