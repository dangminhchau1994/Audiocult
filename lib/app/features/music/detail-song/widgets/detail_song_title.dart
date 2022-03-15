import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:flutter/material.dart';

import '../../../../utils/datetime/date_time_utils.dart';

class DetailSongTitle extends StatelessWidget {
  const DetailSongTitle({
    Key? key,
    this.title,
    this.artistName,
    this.time,
  }) : super(key: key);

  final String? title;
  final String? artistName;
  final String? time;

  @override
  Widget build(BuildContext context) {
    return PositionedDirectional(
      top: 238,
      start: 16,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title ?? '',
            style: context.bodyTextPrimaryStyle()!.copyWith(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Text(
                artistName ?? '',
                style: context.bodyTextPrimaryStyle()!.copyWith(
                      color: Colors.white,
                      fontSize: 14,
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
                DateTimeUtils.formatyMMMMd(int.parse(time ?? '')),
                style: context.bodyTextPrimaryStyle()!.copyWith(
                      color: Colors.white,
                      fontSize: 14,
                    ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
