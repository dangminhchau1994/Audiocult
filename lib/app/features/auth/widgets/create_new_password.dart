import 'package:audio_cult/app/base/bloc_handle.dart';
import 'package:audio_cult/app/features/auth/create_new_password/reset_password_bloc.dart';
import 'package:audio_cult/app/injections.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:audio_cult/app/utils/route/app_route.dart';
import 'package:audio_cult/app/utils/toast/toast_utils.dart';
import 'package:flutter/material.dart';

import '../../../../w_components/buttons/common_button.dart';
import '../../../../w_components/textfields/common_input.dart';
import '../../../utils/constants/app_colors.dart';
import '../../../utils/constants/app_dimens.dart';

class CreateNewPasswordPage extends StatefulWidget {
  final String? codeSent;
  const CreateNewPasswordPage({Key? key, this.codeSent}) : super(key: key);

  @override
  State<CreateNewPasswordPage> createState() => _CheckEmailPageState();
}

class _CheckEmailPageState extends State<CreateNewPasswordPage> {
  final ResetPasswordBloc _resetPasswordBloc = ResetPasswordBloc(locator.get());
  String _password = '';
  String _newPassword = '';
  bool isHiddenPassword = true;
  bool isHiddenNewPassword = true;

  @override
  void initState() {
    super.initState();
    _resetPasswordBloc.navigateMainStream.listen((event) {
      if (event) {
        ToastUtility.showSuccess(context: context, message: 'Password successfully updated.');
        Navigator.pushNamedAndRemoveUntil(context, AppRoute.routeLogin, (route) => false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocHandle(
      bloc: _resetPasswordBloc,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: kVerticalSpacing),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: kVerticalSpacing),
              child: Text(
                context.localize.t_create_new_password,
                style: context.headerStyle()?.copyWith(),
              ),
            ),
            Text(
              context.localize.t_sub_create,
              style: context.bodyTextStyle()?.copyWith(color: AppColors.unActiveLabelItem),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: kVerticalSpacing),
              child: CommonInput(
                togglePassword: () {
                  setState(() {
                    isHiddenPassword = !isHiddenPassword;
                  });
                },
                isHidden: isHiddenPassword,
                isPasswordField: true,
                hintText: context.localize.t_new_password,
                onChanged: (v) {
                  setState(() {
                    _password = v;
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: kVerticalSpacing),
              child: CommonInput(
                togglePassword: () {
                  setState(() {
                    isHiddenNewPassword = !isHiddenNewPassword;
                  });
                },
                isHidden: isHiddenNewPassword,
                isPasswordField: true,
                hintText: context.localize.t_confirm_password,
                onChanged: (v) {
                  setState(() {
                    _newPassword = v;
                  });
                },
              ),
            ),
            CommonButton(
              color: AppColors.activeLabelItem,
              text: context.localize.t_save,
              onTap: () {
                if (_newPassword.isEmpty) {
                  ToastUtility.showError(context: context, message: 'Can not be empty!');
                  return;
                }
                if (_newPassword != _password) {
                  ToastUtility.showError(context: context, message: 'Password do not match!');

                  return;
                }

                _resetPasswordBloc.resetPassword(_password, widget.codeSent!);
              },
            )
          ],
        ),
      ),
    );
  }
}
