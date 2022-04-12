import 'package:audio_cult/app/utils/constants/app_dimens.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:audio_cult/l10n/l10n.dart';
import 'package:flutter/material.dart';

import '../../../../w_components/buttons/common_button.dart';
import '../../../../w_components/textfields/common_input.dart';
import '../../../utils/constants/app_colors.dart';

class FourthStepScreen extends StatelessWidget {
  const FourthStepScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: kHorizontalSpacing,
          vertical: kVerticalSpacing,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.l10n.t_add_host_detail,
              style: context.bodyTextStyle()?.copyWith(color: Colors.white, fontSize: 18),
            ),
            const SizedBox(height: 10),
            Text(
              context.l10n.t_help_text,
              style: context.bodyTextStyle()?.copyWith(color: AppColors.subTitleColor, fontSize: 16),
            ),
            const SizedBox(height: 20),
            CommonInput(
              hintText: context.l10n.t_host_name,
            ),
            const SizedBox(height: 20),
            const CommonInput(
              hintText: 'Description',
              maxLine: 5,
            ),
            const SizedBox(height: 20),
            CommonInput(
              hintText: context.l10n.t_host_website,
            ),
            const SizedBox(height: 20),
            CommonInput(
              hintText: context.l10n.t_host_facebook,
            ),
            const SizedBox(height: 20),
            CommonInput(
              hintText: context.l10n.t_host_twitter,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10, top: 40),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: CommonButton(
                      color: AppColors.ebonyClay,
                      text: context.l10n.btn_back,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    flex: 2,
                    child: CommonButton(
                      color: AppColors.primaryButtonColor,
                      text: context.l10n.btn_next,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
