import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:audio_cult/app/utils/route/app_route.dart';
import 'package:audio_cult/l10n/l10n.dart';
import 'package:flutter/material.dart';

import '../../../../w_components/buttons/common_button.dart';
import '../../../../w_components/textfields/common_input.dart';
import '../../../utils/constants/app_colors.dart';
import '../../../utils/constants/app_dimens.dart';

class CreateNewPasswordPage extends StatefulWidget {
  const CreateNewPasswordPage({Key? key}) : super(key: key);

  @override
  State<CreateNewPasswordPage> createState() => _CheckEmailPageState();
}

class _CheckEmailPageState extends State<CreateNewPasswordPage> {
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
              context.l10n.t_create_new_password,
              style: context.headerStyle()?.copyWith(),
            ),
          ),
          Text(
            context.l10n.t_sub_create,
            style: context.bodyTextStyle()?.copyWith(color: AppColors.unActiveLabelItem),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: kVerticalSpacing),
            child: CommonInput(hintText: context.l10n.t_new_password),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: kVerticalSpacing),
            child: CommonInput(hintText: context.l10n.t_confirm_password),
          ),
          CommonButton(
            color: AppColors.activeLabelItem,
            text: context.l10n.t_save,
            onTap: () {
              Navigator.pushNamed(context, AppRoute.routeCheckEmail);
            },
          )
        ],
      ),
    );
  }
}
