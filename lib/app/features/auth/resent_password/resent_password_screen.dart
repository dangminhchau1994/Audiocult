import 'package:audio_cult/app/features/auth/widgets/w_auth_page.dart';
import 'package:audio_cult/app/utils/constants/app_colors.dart';
import 'package:audio_cult/w_components/appbar/common_appbar.dart';
import 'package:audio_cult/w_components/w_keyboard_dismiss.dart';
import 'package:flutter/material.dart';

import '../widgets/resent_password_page.dart';

class ResentPasswordScreen extends StatefulWidget {
  const ResentPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ResentPasswordScreen> createState() => _ResentPasswordScreenState();
}

class _ResentPasswordScreenState extends State<ResentPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return WKeyboardDismiss(
      child: Scaffold(
        backgroundColor: AppColors.mainColor,
        appBar: const CommonAppBar(),
        body: SafeArea(
          top: false,
          child: WAuthPage(
            isHideHeader: MediaQuery.of(context).viewInsets.bottom > 0,
            isShowIconRight: false,
            child: const ResentPasswordPage(),
          ),
        ),
      ),
    );
  }
}
