import 'package:audio_cult/app/utils/constants/app_assets.dart';
import 'package:audio_cult/app/utils/constants/app_colors.dart';
import 'package:audio_cult/app/utils/datetime/date_time_utils.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:audio_cult/w_components/buttons/w_button_inkwell.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class ItemUploadedMusic extends StatelessWidget {
  final PlatformFile? file;
  final Duration? duration;
  final Function(String?)? onRemove;
  const ItemUploadedMusic({Key? key, this.duration, this.file, this.onRemove}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: AppColors.secondaryButtonColor, borderRadius: BorderRadius.circular(6)),
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
                  file!.name,
                  style: context.bodyTextStyle()?.copyWith(fontSize: 16),
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  printDuration(duration!),
                  style: context.bodyTextStyle()?.copyWith(color: AppColors.subTitleColor),
                )
              ],
            ),
          ),
          WButtonInkwell(
            borderRadius: BorderRadius.circular(40),
            onPressed: () {
              onRemove?.call(file!.identifier);
            },
            child: Container(
              padding: const EdgeInsets.all(16),
              child: const Icon(Icons.close_rounded),
            ),
          )
        ],
      ),
    );
  }
}
