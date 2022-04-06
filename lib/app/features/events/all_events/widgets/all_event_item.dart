import 'package:audio_cult/app/data_source/models/responses/events/event_response.dart';
import 'package:audio_cult/app/utils/constants/app_assets.dart';
import 'package:audio_cult/app/utils/constants/app_colors.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../w_components/images/common_image_network.dart';

class AllEventItem extends StatelessWidget {
  const AllEventItem({
    Key? key,
    this.data,
    this.width,
  }) : super(key: key);

  final EventResponse? data;
  final double? width;

  @override
  Widget build(BuildContext context) {
    final date = data?.eventDate?.split('-')[0].split(', ')[1].split(' ')[1];
    final month = data?.eventDate?.split('-')[0].split(', ')[1].split(' ')[0];
    final hour = DateFormat.jm()
        .format(DateFormat('hh:mm').parse(data?.eventDate?.split('-')[0].split(', ')[2].split(' ')[1] ?? ''));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            CommonImageNetWork(
              width: width ?? double.infinity,
              height: 176,
              imagePath: data?.imagePath ?? '',
            ),
            Positioned(
              right: 10,
              top: 10,
              child: Column(
                children: [
                  Container(
                    width: 110,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppColors.mainColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        Text(
                          date ?? '',
                          style: context.bodyTextStyle()?.copyWith(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          month ?? '',
                          style: context.bodyTextStyle()?.copyWith(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    width: 110,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          AppAssets.timeIcon,
                          width: 18,
                          height: 18,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          hour,
                          style: context.bodyTextStyle()?.copyWith(
                                color: Colors.black,
                                fontSize: 12,
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
          data?.title ?? '',
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
              data?.location ?? '',
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
