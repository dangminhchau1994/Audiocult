import 'package:audio_cult/app/utils/constants/app_assets.dart';
import 'package:audio_cult/app/utils/constants/app_colors.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../w_components/images/common_image_network.dart';

class AllEventItem extends StatelessWidget {
  const AllEventItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            const CommonImageNetWork(
              width: double.infinity,
              height: 176,
              imagePath: 'http://staging.audiocult.net/PF.Base/file/pic/photo/620da96306324.jpeg',
            ),
            Positioned(
              right: 10,
              top: 10,
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: AppColors.mainColor,
                    ),
                    child: Column(
                      children: [
                        Text(
                          '28',
                          style: context.bodyTextStyle()?.copyWith(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'JAN',
                          style: context.bodyTextStyle()?.copyWith(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          AppAssets.timeIcon,
                          width: 20,
                          height: 20,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '4 PM',
                          style: context.bodyTextStyle()?.copyWith(
                                color: Colors.black,
                                fontSize: 14,
                              ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
        const SizedBox(height: 10),
        Text(
          'Oblivion : Chapter 2',
          style: context.bodyTextStyle()?.copyWith(
                color: Colors.white,
                fontSize: 14,
              ),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            SvgPicture.asset(
              AppAssets.locationIcon,
              width: 20,
              height: 20,
            ),
            const SizedBox(width: 8),
            Text(
              'The Dunes - Ras al-Khaimah - United Arab Emirates',
              style: context.bodyTextStyle()?.copyWith(
                    color: AppColors.subTitleColor,
                    fontSize: 12,
                  ),
            ),
          ],
        )
      ],
    );
  }
}
