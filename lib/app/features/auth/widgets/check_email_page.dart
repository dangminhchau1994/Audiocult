import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:audio_cult/l10n/l10n.dart';
import 'package:flutter/material.dart';

import '../../../utils/constants/app_colors.dart';
import '../../../utils/constants/app_dimens.dart';

class CheckEmailPage extends StatefulWidget {
  const CheckEmailPage({Key? key}) : super(key: key);

  @override
  State<CheckEmailPage> createState() => _CheckEmailPageState();
}

class _CheckEmailPageState extends State<CheckEmailPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: kVerticalSpacing),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: kVerticalSpacing),
            child: Text(
              context.l10n.t_check_email,
              style: context.headerStyle()?.copyWith(),
            ),
          ),
          Text(
            context.l10n.t_sub_check_email,
            style: context.bodyTextStyle()?.copyWith(color: AppColors.unActiveLabelItem),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: kVerticalSpacing * 2),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.5,
              height: 1,
              color: AppColors.inputFillColor,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: kVerticalSpacing),
            child: Text(
              context.l10n.t_bottom_check_email,
              style: context.bodyTextStyle()?.copyWith(color: AppColors.unActiveLabelItem),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Text(
              context.l10n.t_bottom1_check_email,
              style: context.bodyTextStyle()?.copyWith(color: AppColors.lightBlueColor),
            ),
          ),
        ],
      ),
    );
  }
}
