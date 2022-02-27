import 'package:audio_cult/app/utils/constants/app_assets.dart';
import 'package:audio_cult/app/utils/constants/app_colors.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SongOfDay extends StatelessWidget {
  const SongOfDay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'SONG OF THE DAY',
          style: context.bodyTextPrimaryStyle()!.copyWith(
                color: AppColors.subTitleColor,
              ),
        ),
        const SizedBox(
          height: 12,
        ),
        Stack(
          children: [
            CachedNetworkImage(
              width: double.infinity,
              height: 140,
              imageUrl:
                  'https://images.macrumors.com/t/vMbr05RQ60tz7V_zS5UEO9SbGR0=/1600x900/smart/article-new/2018/05/apple-music-note.jpg',
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
                child: CircularProgressIndicator(
                  color: AppColors.primaryButtonColor,
                ),
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ],
        ),
        const SizedBox(
          height: 12,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Plus(Original Mix)',
                  style: context.bodyTextPrimaryStyle()!.copyWith(
                        fontSize: 16,
                      ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    Text(
                      'LINDE',
                      style: context.bodyTextPrimaryStyle()!.copyWith(
                            color: AppColors.subTitleColor,
                            fontSize: 16,
                          ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Icon(
                      Icons.circle,
                      color: Colors.grey,
                      size: 5,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      'May 7.2021',
                      style: context.bodyTextPrimaryStyle()!.copyWith(
                            color: AppColors.subTitleColor,
                            fontSize: 16,
                          ),
                    ),
                  ],
                )
              ],
            ),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.secondaryButtonColor,
              ),
              child: const Icon(
                Icons.play_arrow,
                color: Colors.white,
              ),
            )
          ],
        )
      ],
    );
  }
}
