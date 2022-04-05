import 'package:audio_cult/app/data_source/models/responses/events/event_response.dart';
import 'package:audio_cult/app/utils/constants/app_colors.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:audio_cult/w_components/images/common_image_network.dart';
import 'package:flutter/material.dart';

class PopularEventItem extends StatefulWidget {
  const PopularEventItem({
    Key? key,
    this.data,
  }) : super(key: key);

  final EventResponse? data;

  @override
  State<PopularEventItem> createState() => _PopularEventItemState();
}

class _PopularEventItemState extends State<PopularEventItem> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CommonImageNetWork(
          width: 240,
          height: 176,
          imagePath: 'http://staging.audiocult.net/PF.Base/file/pic/photo/620da96306324.jpeg',
        ),
        const SizedBox(
          height: 10,
        ),
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
            Text(
              'JAN 28-30, 2021',
              style: context.bodyTextPrimaryStyle()!.copyWith(
                    color: AppColors.subTitleColor,
                    fontSize: 12,
                  ),
            ),
            const SizedBox(
              width: 4,
            ),
            const Icon(
              Icons.circle,
              color: Colors.grey,
              size: 2,
            ),
            const SizedBox(
              width: 4,
            ),
            Text(
              '4 PM',
              style: context.bodyTextPrimaryStyle()!.copyWith(
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
