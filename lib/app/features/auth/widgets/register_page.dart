import 'package:audio_cult/app/utils/constants/app_colors.dart';
import 'package:audio_cult/app/utils/constants/app_dimens.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:audio_cult/l10n/l10n.dart';
import 'package:audio_cult/w_components/buttons/common_button.dart';
import 'package:audio_cult/w_components/checkbox/common_checkbox.dart';
import 'package:flutter/material.dart';

import '../../../../w_components/textfields/common_input.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: kHorizontalSpacing),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: kVerticalSpacing),
            child: CommonInput(hintText: context.l10n.t_full_name),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: kVerticalSpacing),
            child: CommonInput(hintText: context.l10n.t_email),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: kVerticalSpacing),
            child: CommonInput(hintText: context.l10n.t_password),
          ),
          Container(
            child: CommonCheckbox(
              isChecked: false,
              title: context.l10n.t_sub_register_checkbox,
              onChanged: (value) {},
            ),
          ),
          Text.rich(
            TextSpan(
              text: context.l10n.t_register_text,
              style: context.bodyTextStyle()?.copyWith(color: AppColors.unActiveLabelItem),
              children: <TextSpan>[
                TextSpan(
                  text: context.l10n.t_term,
                  style: context.bodyTextStyle()?.copyWith(
                        color: AppColors.unActiveLabelItem,
                        decoration: TextDecoration.underline,
                      ),
                ),
                // can add more TextSpans here...
              ],
            ),
          ),
          const SizedBox(
            height: kVerticalSpacing,
          ),
          CommonButton(
            color: AppColors.activeLabelItem,
            text: context.l10n.t_sign_up,
            onTap: () {},
          )
        ],
      ),
    );
  }
}
