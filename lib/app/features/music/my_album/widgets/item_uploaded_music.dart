import 'package:audio_cult/app/utils/constants/app_assets.dart';
import 'package:audio_cult/app/utils/constants/app_colors.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:flutter/material.dart';

class ItemUploadedMusic extends StatelessWidget {
  const ItemUploadedMusic({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: AppColors.semiMainColor, borderRadius: BorderRadius.circular(6)),
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.all(8),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: AppColors.inputFillColor, borderRadius: BorderRadius.circular(6)),
            child: Image.asset(
              AppAssets.icMusicNote,
              width: 24,
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Song',
                  style: context.bodyTextStyle()?.copyWith(fontSize: 16),
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  '02:27',
                  style: context.bodyTextStyle()?.copyWith(color: AppColors.subTitleColor),
                )
              ],
            ),
          ),
          IconButton(onPressed: () {}, icon: Icon(Icons.close_rounded))
        ],
      ),
    );
  }
}
