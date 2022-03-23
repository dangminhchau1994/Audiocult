import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:audio_cult/l10n/l10n.dart';
import 'package:flutter/material.dart';

import '../../../../../w_components/buttons/common_button.dart';
import '../../../../../w_components/dropdown/common_dropdown.dart';
import '../../../../utils/constants/app_colors.dart';
import '../../../../utils/constants/app_dimens.dart';

class PrivacyStep extends StatefulWidget {
  final Function()? onNext;

  final Function()? onBack;
  const PrivacyStep({Key? key, this.onBack, this.onNext}) : super(key: key);

  @override
  State<PrivacyStep> createState() => _PrivacyStepState();
}

class _PrivacyStepState extends State<PrivacyStep> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: kHorizontalSpacing),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(context.l10n.t_privacy, style: context.bodyTextStyle()?.copyWith(fontSize: 18)),
          const SizedBox(
            height: kVerticalSpacing / 2,
          ),
          Text(
            context.l10n.t_sub_privacy,
            style: context.bodyTextStyle()?.copyWith(color: AppColors.unActiveLabelItem),
          ),
          const SizedBox(
            height: kVerticalSpacing,
          ),
          CommonDropdown(hint: context.l10n.t_genres, data: []),
          const SizedBox(
            height: kVerticalSpacing,
          ),
          Text(context.l10n.t_comment_privacy, style: context.bodyTextStyle()?.copyWith(fontSize: 18)),
          const SizedBox(
            height: kVerticalSpacing / 2,
          ),
          Text(
            context.l10n.t_sub_comment_privacy,
            style: context.bodyTextStyle()?.copyWith(color: AppColors.unActiveLabelItem),
          ),
          const SizedBox(
            height: kVerticalSpacing,
          ),
          CommonDropdown(hint: context.l10n.t_genres, data: []),
          const SizedBox(
            height: kVerticalSpacing,
          ),
          Row(
            children: [
              Expanded(
                child: CommonButton(
                  color: AppColors.semiMainColor,
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
    );
  }
}
