import 'package:audio_cult/app/features/auth/widgets/login_page.dart';
import 'package:audio_cult/app/features/auth/widgets/register_page.dart';
import 'package:audio_cult/app/features/auth/widgets/w_auth_page.dart';
import 'package:audio_cult/app/utils/constants/app_colors.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:audio_cult/w_components/w_keyboard_dismiss.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with SingleTickerProviderStateMixin {
  TabController? _controller;
  @override
  void initState() {
    super.initState();
    _controller = TabController(vsync: this, length: 2, initialIndex: 1);
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      // resizeToAvoidBottomInset: false,
      body: WKeyboardDismiss(
        child: Center(
          child: SafeArea(
            top: false,
            child: WAuthPage(
              isHideHeader: MediaQuery.of(context).viewInsets.bottom > 0,
              child: DefaultTabController(
                length: 2,
                initialIndex: 1,
                child: Column(
                  children: [
                    TabBar(
                      controller: _controller,
                      onTap: (i) {
                        FocusScope.of(context).requestFocus(FocusNode());
                      },
                      labelStyle: context.bodyTextStyle(),
                      tabs: [
                        Tab(text: context.localize.t_sign_up),
                        Tab(text: context.localize.t_sign_in),
                      ],
                    ),
                    Expanded(
                      child: Center(
                        child: TabBarView(
                          physics: const NeverScrollableScrollPhysics(),
                          controller: _controller,
                          children: [
                            RegisterPage(
                              onSuccess: () {
                                // _controller?.animateTo(1);
                              },
                            ),
                            const LoginPage(),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
