import 'package:audio_cult/app/base/bloc_handle.dart';
import 'package:audio_cult/app/injections.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';

import 'package:flutter/material.dart';

import '../../../../w_components/buttons/common_button.dart';
import '../../../../w_components/textfields/common_input.dart';
import '../../../utils/constants/app_colors.dart';
import '../../../utils/constants/app_dimens.dart';
import '../../../utils/route/app_route.dart';
import '../check_email/check_email_bloc.dart';

class CheckEmailPage extends StatefulWidget {
  const CheckEmailPage({Key? key}) : super(key: key);

  @override
  State<CheckEmailPage> createState() => _CheckEmailPageState();
}

class _CheckEmailPageState extends State<CheckEmailPage> {
  String _codeSent = '';
  final CheckEmailBloc _checkEmailBloc = CheckEmailBloc(locator.get());
  @override
  void initState() {
    super.initState();
    _checkEmailBloc.navigateMainStream.listen((event) {
      if (event) {
        Navigator.pushNamed(context, AppRoute.routeResetPassword, arguments: _codeSent);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocHandle(
      bloc: _checkEmailBloc,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: kVerticalSpacing),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: kVerticalSpacing),
              child: Text(
                context.localize.t_check_email,
                style: context.headerStyle()?.copyWith(),
              ),
            ),
            Text(
              context.localize.t_sub_check_email,
              style: context.bodyTextStyle()?.copyWith(color: AppColors.unActiveLabelItem),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: kVerticalSpacing),
              child: CommonInput(
                hintText: context.localize.t_input_code,
                onChanged: (v) {
                  setState(() {
                    _codeSent = v;
                  });
                },
              ),
            ),
            CommonButton(
                color: AppColors.activeLabelItem,
                text: context.localize.t_submit,
                onTap: () {
                  _checkEmailBloc.sendCode(_codeSent);
                }),
            Padding(
              padding: const EdgeInsets.only(top: kVerticalSpacing),
              child: Text(
                context.localize.t_bottom_check_email,
                style: context.bodyTextStyle()?.copyWith(color: AppColors.unActiveLabelItem),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Text(
                context.localize.t_bottom1_check_email,
                style: context.bodyTextStyle()?.copyWith(color: AppColors.lightBlueColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
