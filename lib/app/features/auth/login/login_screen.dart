import 'package:audio_cult/app/features/auth/widgets/login_page.dart';
import 'package:audio_cult/app/features/auth/widgets/register_page.dart';
import 'package:audio_cult/app/features/auth/widgets/w_auth_page.dart';
import 'package:audio_cult/app/utils/constants/app_colors.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:audio_cult/l10n/l10n.dart';
import 'package:audio_cult/w_components/w_keyboard_dismiss.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      resizeToAvoidBottomInset: false,
      body: WKeyboardDismiss(
        child: SafeArea(
          top: false,
          child: WAuthPage(
            child: DefaultTabController(
              length: 2,
              initialIndex: 1,
              child: Column(
                children: [
                  TabBar(
                    onTap: (i) {
                      FocusScope.of(context).requestFocus(FocusNode());
                    },
                    labelStyle: context.bodyTextStyle(),
                    tabs: [
                      Tab(text: context.l10n.t_sign_up),
                      Tab(text: context.l10n.t_sign_in),
                    ],
                  ),
                  const Expanded(
                    child: TabBarView(
                      children: [
                        RegisterPage(),
                        LoginPage(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
