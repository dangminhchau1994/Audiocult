import 'package:audio_cult/app/base/bloc_handle.dart';
import 'package:audio_cult/app/data_source/models/requests/register_request.dart';
import 'package:audio_cult/app/features/auth/register/register_bloc.dart';
import 'package:audio_cult/app/utils/constants/app_colors.dart';
import 'package:audio_cult/app/utils/constants/app_dimens.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:audio_cult/l10n/l10n.dart';
import 'package:audio_cult/w_components/appbar/common_appbar.dart';
import 'package:audio_cult/w_components/buttons/common_button.dart';
import 'package:audio_cult/w_components/checkbox/common_checkbox.dart';
import 'package:country_list_pick/country_list_pick.dart';
import 'package:disposing/disposing.dart';
import 'package:flutter/material.dart';

import '../../../../w_components/textfields/common_input.dart';
import '../../../injections.dart';
import '../../../utils/mixins/disposable_state_mixin.dart';
import '../../../utils/toast_utils.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> with DisposableStateMixin {
  bool isCheck = false;
  String _fullName = '';
  String _userName = '';
  String _email = '';
  String _country = '';
  String _password = '';
  final RegisterBloc _registerBloc = RegisterBloc(locator.get(), locator.get());

  @override
  void initState() {
    super.initState();
    _registerBloc.navigateMainStream.listen((data) {
      ToastUtility.showSuccess(context: context, message: 'Register successful!');
    }).disposeOn(disposeBag);
  }

  @override
  Widget build(BuildContext context) {
    return BlocHandle(
      bloc: _registerBloc,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: kHorizontalSpacing / 2),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 8),
              padding: const EdgeInsets.symmetric(vertical: kVerticalSpacing),
              child: CommonInput(
                hintText: context.l10n.t_full_name,
                onChanged: (value) {
                  setState(() {
                    _fullName = value;
                  });
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 8),
              padding: const EdgeInsets.only(bottom: kVerticalSpacing / 2),
              child: CommonInput(
                hintText: context.l10n.t_user_name,
                onChanged: (value) {
                  setState(() {
                    _userName = value;
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: kVerticalSpacing / 2),
              child: CountryListPick(
                appBar: CommonAppBar(
                  title: context.l10n.t_choose_country,
                ),
                theme: CountryTheme(
                  isShowFlag: true,
                  isShowTitle: true,
                  isShowCode: true,
                  isDownIcon: true,
                  showEnglishName: true,
                ),
                onChanged: (CountryCode? code) {
                  setState(() {
                    _country = code!.code!;
                  });
                },
                pickerBuilder: (_, value) {
                  return Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.inputFillColor,
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(color: AppColors.outlineBorderColor, width: 2),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          value!.code == 'AF' ? context.l10n.t_location : '${value.name!} (${value.code!})',
                          style: context.body1TextStyle()?.copyWith(color: Colors.white),
                        ),
                        const Icon(Icons.keyboard_arrow_down_rounded, color: Colors.white)
                      ],
                    ),
                  );
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 8),
              padding: const EdgeInsets.only(bottom: kVerticalSpacing),
              child: CommonInput(
                hintText: context.l10n.t_email,
                onChanged: (value) {
                  setState(() {
                    _email = value;
                  });
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 8),
              padding: const EdgeInsets.only(bottom: kVerticalSpacing),
              child: CommonInput(
                hintText: context.l10n.t_password,
                isHidden: true,
                isPasswordField: true,
                onChanged: (value) {
                  setState(() {
                    _password = value;
                  });
                },
              ),
            ),
            CommonCheckbox(
              isChecked: isCheck,
              title: context.l10n.t_sub_register_checkbox,
              onChanged: (value) {
                setState(() {
                  isCheck = value;
                });
              },
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
              color: isCheck ? AppColors.activeLabelItem : AppColors.primaryButtonColor,
              text: context.l10n.t_sign_up,
              onTap: !isCheck
                  ? null
                  : () {
                      final registerRequest = RegisterRequest()
                        ..valFullName = _fullName
                        ..valEmail = _email
                        ..valUserName = _userName
                        ..valCountryIso = _country
                        ..valPassword = _password;

                      _registerBloc.submitRegister(registerRequest);
                    },
            )
          ],
        ),
      ),
    );
  }
}
