import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:flutter/material.dart';

import '../../../../utils/constants/app_colors.dart';

class DetailSongTitle extends StatelessWidget {
  const DetailSongTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PositionedDirectional(
      top: 238,
      start: 16,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'LOVE (Extended Version) D# 138b ',
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
                'LINDE',
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
                'May 7, 2021',
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
