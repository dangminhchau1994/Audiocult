import 'package:audio_cult/app/base/bloc_handle.dart';
import 'package:audio_cult/app/data_source/models/requests/login_request.dart';
import 'package:audio_cult/app/features/auth/login/login_bloc.dart';
import 'package:audio_cult/app/injections.dart';
import 'package:audio_cult/app/utils/constants/app_colors.dart';
import 'package:audio_cult/app/utils/constants/app_constants.dart';
import 'package:audio_cult/app/utils/constants/app_dimens.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:audio_cult/app/utils/route/app_route.dart';
import 'package:audio_cult/l10n/l10n.dart';
import 'package:audio_cult/w_components/buttons/common_button.dart';
import 'package:disposing/disposing.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import '../../../../w_components/textfields/common_input.dart';
import '../../../data_source/local/pref_provider.dart';
import '../../../utils/mixins/disposable_state_mixin.dart';
import '../../../utils/toast/toast_utils.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with DisposableStateMixin, AutomaticKeepAliveClientMixin {
  final LoginBloc _loginBloc = LoginBloc(locator.get(), locator.get());
  String _email = '';
  String _password = '';
  bool isHiddenPassword = true;
  @override
  void initState() {
    super.initState();
    _loginBloc.navigateMainStream.listen((profile) {
      ToastUtility.showSuccess(context: context, message: 'Login successful!');
      Navigator.pushNamedAndRemoveUntil(context, AppRoute.routeMain, (route) => false);
    }).disposeOn(disposeBag);
  }

  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    return BlocHandle(
      bloc: _loginBloc,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: kHorizontalSpacing),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: kVerticalSpacing),
              child: CommonInput(
                hintText: context.l10n.t_email,
                onChanged: (value) {
                  setState(() {
                    _email = value;
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: kVerticalSpacing),
              child: CommonInput(
                togglePassword: () {
                  setState(() {
                    isHiddenPassword = !isHiddenPassword;
                  });
                },
                isHidden: isHiddenPassword,
                isPasswordField: true,
                hintText: context.l10n.t_password,
                onChanged: (value) {
                  setState(() {
                    _password = value;
                  });
                },
              ),
            ),
            Container(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, AppRoute.routeForgotPassword);
                },
                child: Text(
                  context.l10n.t_forgot_password,
                  style: context.bodyTextStyle()?.copyWith(color: AppColors.lightBlueColor),
                ),
              ),
            ),
            const SizedBox(
              height: kVerticalSpacing,
            ),
            CommonButton(
              color: AppColors.activeLabelItem,
              text: context.l10n.t_sign_in,
              onTap: () async {
                final loginRequest = LoginRequest()
                  ..clientId = AppConstants.clientId
                  ..clientSecret = AppConstants.clientSecret
                  ..grantType = AppConstants.grantType
                  ..username = _email
                  ..password = _password;
                if (locator.get<PrefProvider>().fcmToken == null) {
                  final fcmToken = await FirebaseMessaging.instance.getToken();
                  await locator.get<PrefProvider>().setFCMToken(fcmToken ?? '');
                }
                loginRequest.fcmToken = locator.get<PrefProvider>().fcmToken;
                _loginBloc.submitLogin(loginRequest);
              },
            )
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
