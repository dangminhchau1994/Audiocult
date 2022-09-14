import 'package:audio_cult/app/base/bloc_handle.dart';
import 'package:audio_cult/app/data_source/local/pref_provider.dart';
import 'package:audio_cult/app/data_source/models/requests/remove_account_request.dart';
import 'package:audio_cult/app/injections.dart';
import 'package:audio_cult/app/utils/constants/app_dimens.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:audio_cult/app/utils/toast/toast_utils.dart';
import 'package:audio_cult/di/bloc_locator.dart';
import 'package:audio_cult/w_components/appbar/common_appbar.dart';
import 'package:audio_cult/w_components/buttons/common_button.dart';
import 'package:audio_cult/w_components/textfields/common_input.dart';
import 'package:flutter/material.dart';
import '../../../utils/constants/app_colors.dart';
import '../../../utils/route/app_route.dart';
import 'account_settings_bloc.dart';

class DeleteAccountScreen extends StatefulWidget {
  const DeleteAccountScreen({Key? key}) : super(key: key);

  @override
  State<DeleteAccountScreen> createState() => _DeleteAccountScreenState();
}

class _DeleteAccountScreenState extends State<DeleteAccountScreen> {
  final _bloc = getIt.get<AccountSettingsBloc>();
  bool _isHiddenPassword = true;
  String _feedBack = '';
  String _password = '';

  @override
  void initState() {
    super.initState();
    _bloc.deleteAccountStream.listen((event) async {
      if (event.isSuccess!) {
        await Navigator.pushNamedAndRemoveUntil(context, AppRoute.routeLogin, (route) => false);
        await locator<PrefProvider>().clearAuthentication();
        await locator<PrefProvider>().clearUserId();
        _bloc.clearProfile();
      } else {
        ToastUtility.showError(context: context, message: context.localize.t_invalid_password);
      }
    });
  }

  bool _isValidated() {
    return _feedBack.isNotEmpty && _password.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return BlocHandle(
      bloc: _bloc,
      child: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Scaffold(
          backgroundColor: AppColors.mainColor,
          appBar: CommonAppBar(
            title: context.localize.t_cancel_account,
          ),
          body: Container(
            margin: const EdgeInsets.symmetric(
              horizontal: kHorizontalSpacing,
              vertical: kVerticalSpacing,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  context.localize.t_please_tell_us_why,
                  style: context.bodyTextStyle()?.copyWith(color: Colors.white, fontSize: 16),
                ),
                const SizedBox(height: 8),
                CommonInput(
                  maxLine: 3,
                  onChanged: (value) {
                    setState(() {
                      _feedBack = value;
                    });
                  },
                ),
                const SizedBox(height: 14),
                Text(
                  context.localize.t_enter_your_password,
                  style: context.bodyTextStyle()?.copyWith(color: Colors.white, fontSize: 16),
                ),
                const SizedBox(height: 8),
                CommonInput(
                  isHidden: _isHiddenPassword,
                  isPasswordField: true,
                  onChanged: (value) {
                    setState(() {
                      _password = value;
                    });
                  },
                  togglePassword: () {
                    setState(() {
                      _isHiddenPassword = !_isHiddenPassword;
                    });
                  },
                ),
                const SizedBox(height: 30),
                CommonButton(
                  text: context.localize.t_delete_my_account,
                  color: _isValidated() ? AppColors.primaryButtonColor : Colors.grey,
                  onTap: _isValidated()
                      ? () {
                          _bloc.deleteAccount(RemoveAccountRequest(
                            text: _feedBack,
                            password: _password,
                          ));
                        }
                      : null,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
