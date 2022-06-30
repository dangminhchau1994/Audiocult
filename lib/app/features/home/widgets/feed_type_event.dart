import 'package:audio_cult/app/data_source/models/responses/feed/feed_response.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:flutter/material.dart';

import '../../../../w_components/images/common_image_network.dart';
import '../../../utils/constants/app_colors.dart';
import '../../../utils/datetime/date_time_utils.dart';

class FeedTypeEvent extends StatelessWidget {
  const FeedTypeEvent({Key? key, this.event}) : super(key: key);

  final CustomDataCache? event;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonImageNetWork(
          width: double.infinity,
          height: 200,
          imagePath: event?.imagePath,
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
          event?.location ?? '',
          style: context.buttonTextStyle()!.copyWith(
                fontSize: 14,
                color: Colors.white,
              ),
        ),
        const SizedBox(height: 6),
        Text(
          DateTimeUtils.formatWeekDay(int.parse(event?.timeStamp ?? '')),
          style: context.buttonTextStyle()!.copyWith(
                fontSize: 14,
                color: Colors.white,
              ),
        ),
      ],
    );
  }
}
