import 'package:audio_cult/app/utils/constants/app_assets.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_reaction_button/flutter_reaction_button.dart';
import 'package:flutter_svg/svg.dart';

import '../../app/utils/constants/app_colors.dart';

class CommonComment extends StatefulWidget {
  const CommonComment({Key? key}) : super(key: key);

  @override
  State<CommonComment> createState() => _CommonCommentState();
}

class _CommonCommentState extends State<CommonComment> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 8,
        right: 8,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CachedNetworkImage(
            width: 50,
            height: 50,
            imageUrl: 'https://i.pinimg.com/736x/f2/6d/5a/f26d5a37153abe4860740cc93a7d5600.jpg',
            imageBuilder: (context, imageProvider) => Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                ),
                shape: BoxShape.circle,
              ),
            ),
            placeholder: (context, url) => Center(
              child: CircularProgressIndicator(
                color: AppColors.primaryButtonColor,
              ),
            ),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
          const SizedBox(
            width: 10,
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'LINDE',
                      style: context.bodyTextPrimaryStyle()!.copyWith(
                            color: AppColors.lightBlue,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      'at 1:06',
                      style: context.bodyTextPrimaryStyle()!.copyWith(
                            color: AppColors.lightWhiteColor,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Ante eget euismod purus tellus, eget sit. Id phasellus mauris. eget sit. Id eget sit. Id sa',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: context.bodyTextPrimaryStyle()!.copyWith(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(
                  height: 24,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          'two hour ago',
                          style: context.bodyTextPrimaryStyle()!.copyWith(
                                color: AppColors.lightWhiteColor,
                                fontSize: 12,
                              ),
                        ),
                        const SizedBox(
                          width: 18,
                        ),
                        Text(
                          'Reply',
                          style: context.bodyTextPrimaryStyle()!.copyWith(
                                color: Colors.lightBlue,
                                fontSize: 12,
                              ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        SvgPicture.asset(
                          AppAssets.activeHeart,
                          width: 24,
                          height: 24,
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Text(
                          '149',
                          style: context.bodyTextPrimaryStyle()!.copyWith(
                                color: AppColors.lightWhiteColor,
                                fontSize: 14,
                              ),
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
