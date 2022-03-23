import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:audio_cult/l10n/l10n.dart';
import 'package:audio_cult/w_components/buttons/common_button.dart';
import 'package:audio_cult/w_components/textfields/common_input.dart';
import 'package:flutter/material.dart';

import '../../../../../w_components/dropdown/common_dropdown.dart';
import '../../../../utils/constants/app_colors.dart';
import '../../../../utils/constants/app_dimens.dart';

class SongStep2 extends StatefulWidget {
  final Function()? onNext;

  final Function()? onBack;

  const SongStep2({Key? key, this.onBack, this.onNext}) : super(key: key);

  @override
  State<SongStep2> createState() => _SongStep2State();
}

class _SongStep2State extends State<SongStep2> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: kHorizontalSpacing),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(context.l10n.t_main_info, style: context.bodyTextStyle()?.copyWith(fontSize: 18)),
            const SizedBox(
              height: kVerticalSpacing / 2,
            ),
            Text(
              context.l10n.t_sub_main_info,
              style: context.bodyTextStyle()?.copyWith(color: AppColors.unActiveLabelItem),
            ),
            const SizedBox(
              height: kVerticalSpacing,
            ),
            CommonInput(hintText: context.l10n.t_track_title),
            const SizedBox(
              height: 12,
            ),
            CommonDropdown(hint: context.l10n.t_genres, data: []),
            const SizedBox(
              height: 12,
            ),
            CommonDropdown(hint: context.l10n.t_music_type, data: []),
            const SizedBox(
              height: 12,
            ),
            CommonInput(hintText: context.l10n.t_label),
            const SizedBox(
              height: 12,
            ),
            CommonInput(hintText: context.l10n.t_collab_remix),
            const SizedBox(
              height: 12,
            ),
            CommonInput(hintText: context.l10n.t_label),
            const SizedBox(
              height: 12,
            ),
            CommonInput(
              hintText: '* ${context.l10n.t_description}',
              height: 100,
              maxLine: 100,
            ),
            const SizedBox(
              height: 12,
            ),
            CommonInput(
              hintText: context.l10n.t_tags_separate,
            ),
            const SizedBox(
              height: kVerticalSpacing,
            ),
            Text(context.l10n.t_upload_song_cover, style: context.bodyTextStyle()?.copyWith(fontSize: 18)),
            const SizedBox(
              height: kVerticalSpacing / 2,
            ),
            Text(
              context.l10n.t_sub_upload_song_cover,
              style: context.bodyTextStyle()?.copyWith(color: AppColors.unActiveLabelItem),
            ),
            const SizedBox(
              height: kVerticalSpacing,
            ),
            Container(
              height: 160,
              decoration: BoxDecoration(
                color: AppColors.inputFillColor.withOpacity(0.4),
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: AppColors.outlineBorderColor),
              ),
              child: Center(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.activeLabelItem.withOpacity(0.4),
                  ),
                  child: Icon(
                    Icons.add,
                    color: AppColors.activeLabelItem,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: kVerticalSpacing,
            ),
            Row(
              children: [
                Expanded(
                  child: CommonButton(
                    color: AppColors.secondaryButtonColor,
                    text: context.l10n.btn_back,
                    onTap: () {
                      widget.onBack?.call();
                    },
                  ),
                ),
                const SizedBox(
                  width: kVerticalSpacing,
                ),
                Expanded(
                  child: CommonButton(
                    color: AppColors.primaryButtonColor,
                    text: context.l10n.btn_next,
                    onTap: () {
                      widget.onNext?.call();
                    },
                  ),
                )
              ],
            ),
            const SizedBox(
              height: kVerticalSpacing,
            ),
          ],
        ),
      ),
    );
  }
}
