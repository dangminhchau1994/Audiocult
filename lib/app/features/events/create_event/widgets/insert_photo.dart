import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:audio_cult/l10n/l10n.dart';
import 'package:flutter/material.dart';

import '../../../../utils/constants/app_colors.dart';

class InsertPhoto extends StatelessWidget {
  const InsertPhoto({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.activeLabelItem.withOpacity(0.5),
          ),
          child: Center(
            child: Icon(
              Icons.add,
              size: 24,
              color: AppColors.activeLabelItem,
            ),
          ),
        ),
        const SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.l10n.t_insert_photo,
              style: context.bodyTextStyle()?.copyWith(color: Colors.white, fontSize: 14),
            ),
            const SizedBox(height: 8),
            Text(
              context.l10n.t_sub_upload_song_cover,
              style: context.bodyTextStyle()?.copyWith(color: AppColors.unActiveLabelItem, fontSize: 12),
            ),
          ],
        )
      ],
    );
  }
}
