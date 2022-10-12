import 'package:audio_cult/app/utils/constants/app_colors.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:audio_cult/w_components/images/common_image_network.dart';
import 'package:flutter/material.dart';

import '../../../data_source/models/responses/feed/feed_response.dart';

class FeedTypeLink extends StatelessWidget {
  const FeedTypeLink({
    Key? key,
    this.event,
  }) : super(key: key);

  final CustomDataCache? event;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonImageNetWork(
          width: double.infinity,
          height: 200,
          imagePath: event?.image,
        ),
        const SizedBox(height: 10),
        Text(
          event?.title ?? '',
          style: context.buttonTextStyle()!.copyWith(
                fontSize: 18,
                color: AppColors.primaryButtonColor,
              ),
        ),
        const SizedBox(height: 6),
        Text(
          'audiocult.net',
          style: context.buttonTextStyle()!.copyWith(
                fontSize: 16,
                color: Colors.white,
              ),
        ),
        const SizedBox(height: 6),
        Text(
          event?.description ?? '',
          style: context.buttonTextStyle()!.copyWith(
                fontSize: 16,
                color: Colors.white,
              ),
        ),
        const SizedBox(height: 6),
      ],
    );
  }
}
