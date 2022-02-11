import 'package:audio_cult/app/constants/app_assets.dart';
import 'package:audio_cult/app/constants/app_colors.dart';
import 'package:audio_cult/app/constants/app_text_styles.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CommonSongItem extends StatelessWidget {
  const CommonSongItem({
    Key? key,
    this.imageUrl,
    this.title,
    this.subTitle,
    this.imageSize = 40,
    this.numberOrder = '',
    this.onShowMenuItem,
  }) : super(key: key);

  final String? imageUrl;
  final String? title;
  final double? imageSize;
  final String? subTitle;
  final String? numberOrder;
  final Function()? onShowMenuItem;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      horizontalTitleGap: numberOrder!.isNotEmpty ? 0 : 16,
      leading: numberOrder!.isNotEmpty
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '$numberOrder.',
                  style: AppTextStyles.headline,
                ),
              ],
            )
          : CachedNetworkImage(
              width: imageSize,
              height: imageSize,
              imageUrl: imageUrl ?? '' ,
              imageBuilder: (context, imageProvider) => Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              placeholder: (context, url) => const CircularProgressIndicator(),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
      title: Text(
        title ?? '',
        style: AppTextStyles.normal,
      ),
      subtitle: Text(
        subTitle ?? '',
        style: AppTextStyles.regular.copyWith(
          color: AppColors.subTitleColor,
        ),
      ),
      trailing: onShowMenuItem != null
          ? GestureDetector(
              onTap: onShowMenuItem,
              child: SvgPicture.asset(
                AppAssets.horizIcon,
                width: 16,
                height: 16,
              ),
            )
          : const SizedBox(),
    );
  }
}
