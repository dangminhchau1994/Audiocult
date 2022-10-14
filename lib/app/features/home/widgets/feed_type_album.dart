import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:audio_cult/w_components/buttons/w_button_inkwell.dart';
import 'package:flutter/material.dart';

import '../../../../w_components/images/common_image_network.dart';
import '../../../data_source/models/responses/feed/feed_response.dart';
import '../../../utils/constants/app_colors.dart';
import '../../../utils/datetime/date_time_utils.dart';
import '../../../utils/route/app_route.dart';

class FeedTypeAlbum extends StatelessWidget {
  const FeedTypeAlbum({
    Key? key,
    this.customDataCache,
    this.feedStatus,
  }) : super(key: key);

  final CustomDataCache? customDataCache;
  final String? feedStatus;

  @override
  Widget build(BuildContext context) {
    return WButtonInkwell(
      onPressed: () {
        Navigator.pushNamed(
          context,
          AppRoute.routeDetailAlbum,
          arguments: {
            'album_id': customDataCache?.albumId,
          },
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Visibility(
            visible: feedStatus != null,
            child: Text(
              feedStatus ?? '',
              style: context.buttonTextStyle()!.copyWith(
                    fontSize: 16,
                    color: Colors.white,
                  ),
            ),
          ),
          const SizedBox(height: 10),
          CommonImageNetWork(
            width: double.infinity,
            height: 300,
            imagePath: customDataCache?.imagePath,
          ),
          const SizedBox(height: 10),
          Text(
            customDataCache?.name ?? '',
            style: context.buttonTextStyle()!.copyWith(
                  fontSize: 18,
                  color: AppColors.primaryButtonColor,
                ),
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              Text(
                '${customDataCache?.totalPlay.toString() ?? ''} plays',
                style: context.buttonTextStyle()!.copyWith(
                      fontSize: 16,
                      color: Colors.white,
                    ),
              ),
              const SizedBox(width: 8),
              Text(
                '${customDataCache?.totalView.toString() ?? ''} views',
                style: context.buttonTextStyle()!.copyWith(
                      fontSize: 16,
                      color: Colors.white,
                    ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            customDataCache?.text.toString() ?? '',
            style: context.buttonTextStyle()!.copyWith(
                  fontSize: 16,
                  color: Colors.white,
                ),
          ),
          const SizedBox(height: 6),
          Text(
            DateTimeUtils.formatWeekDay(int.parse(customDataCache?.timeStamp ?? '')),
            style: context.buttonTextStyle()!.copyWith(
                  fontSize: 16,
                  color: Colors.white,
                ),
          ),
        ],
      ),
    );
  }
}
