import 'package:audio_cult/app/features/auth/widgets/w_auth_page.dart';
import 'package:audio_cult/app/utils/constants/app_colors.dart';
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
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      body: const SafeArea(
        top: false,
        child: WAuthPage(
          isShowIconRight: false,
          child: ResentPasswordPage(),
        ),
      ),
    );
  }
}
