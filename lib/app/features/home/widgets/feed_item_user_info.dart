import 'package:audio_cult/app/data_source/models/responses/feed/feed_response.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../utils/constants/app_colors.dart';
import '../../../utils/datetime/date_time_utils.dart';

class FeedItemUserInfo extends StatelessWidget {
  const FeedItemUserInfo({
    Key? key,
    this.data,
  }) : super(key: key);

  final FeedResponse? data;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CachedNetworkImage(
          width: 50,
          height: 50,
          imageUrl: data?.userImage ?? '',
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
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${data?.userName ?? ''} ${data?.feedInfo ?? ''}',
              style: context.buttonTextStyle()!.copyWith(
                    fontSize: 16,
                    color: Colors.white,
                  ),
            ),
            const SizedBox(height: 10),
            Text(
              DateTimeUtils.convertToAgo(int.parse(data?.timeStamp ?? '')),
              style: context.buttonTextStyle()!.copyWith(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
            ),
          ],
        )
      ],
    );
  }
}
