import 'package:audio_cult/app/utils/constants/app_colors.dart';
import 'package:audio_cult/app/utils/constants/app_dimens.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:audio_cult/app/utils/route/app_route.dart';
import 'package:audio_cult/l10n/l10n.dart';
import 'package:audio_cult/w_components/buttons/common_button.dart';
import 'package:audio_cult/w_components/checkbox/common_checkbox.dart';
import 'package:flutter/material.dart';

import '../../../../w_components/textfields/common_input.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: kHorizontalSpacing),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: kVerticalSpacing),
            child: CommonInput(hintText: context.l10n.t_email),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: kVerticalSpacing),
            child: CommonInput(hintText: context.l10n.t_password),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 200,
                child: CommonCheckbox(
                  isChecked: false,
                  title: context.l10n.t_remember_me,
                  onChanged: (value) {},
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, AppRoute.routeForgotPassword);
                },
                child: Text(
                  context.l10n.t_forgot_password,
                  style: context.bodyTextStyle()?.copyWith(color: AppColors.lightBlueColor),
                ),
              ),
            ],
          ),
          CommonButton(
            color: AppColors.activeLabelItem,
            text: context.l10n.t_sign_in,
            onTap: () {},
          )
        ],
      ),
    );
  }
}
