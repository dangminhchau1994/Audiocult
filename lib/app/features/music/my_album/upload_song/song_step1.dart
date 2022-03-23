import 'package:audio_cult/app/utils/constants/app_assets.dart';
import 'package:audio_cult/app/utils/constants/app_colors.dart';
import 'package:audio_cult/app/utils/constants/app_dimens.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:audio_cult/l10n/l10n.dart';
import 'package:audio_cult/w_components/buttons/common_button.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

import '../widgets/item_uploaded_music.dart';

class SongStep1 extends StatefulWidget {
  final Function()? onNext;
  const SongStep1({Key? key, this.onNext}) : super(key: key);

  @override
  State<SongStep1> createState() => _SongStep1State();
}

class _SongStep1State extends State<SongStep1> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: kHorizontalSpacing),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(context.l10n.t_upload_music, style: context.bodyTextStyle()?.copyWith(fontSize: 18)),
          const SizedBox(
            height: kVerticalSpacing / 2,
          ),
          Text(
            context.l10n.t_sub_upload_music,
            style: context.bodyTextStyle()?.copyWith(color: AppColors.unActiveLabelItem),
          ),
          const SizedBox(
            height: kVerticalSpacing,
          ),
          DottedBorder(
            borderType: BorderType.RRect,
            radius: const Radius.circular(4),
            color: AppColors.borderOutline,
            dashPattern: const [20, 6],
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              color: AppColors.inputFillColor.withOpacity(0.2),
              height: 168,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    AppAssets.icUploadFrame,
                    width: 48,
                  ),
                  Text(
                    context.l10n.t_upload_music,
                    style: context.bodyTextStyle()?.copyWith(color: AppColors.lightWhiteColor, fontSize: 18),
                  ),
                  Text(
                    context.l10n.t_limit_upload,
                    style: context.bodyTextStyle()?.copyWith(color: AppColors.borderOutline, fontSize: 12),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(
            height: kVerticalSpacing,
          ),
          const ItemUploadedMusic(),
          const SizedBox(
            height: kVerticalSpacing,
          ),
          CommonButton(
            color: AppColors.primaryButtonColor,
            text: context.l10n.btn_next,
            onTap: () {
              widget.onNext?.call();
            },
          )
        ],
      ),
    );
  }
}
