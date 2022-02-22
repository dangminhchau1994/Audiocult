import 'package:audio_cult/app/features/auth/widgets/check_email_page.dart';
import 'package:audio_cult/app/features/auth/widgets/w_auth_page.dart';
import 'package:audio_cult/app/utils/constants/app_colors.dart';
import 'package:flutter/material.dart';

import '../../../../w_components/appbar/common_appbar.dart';

class CheckMailScreen extends StatefulWidget {
  const CheckMailScreen({Key? key}) : super(key: key);

  @override
  State<CheckMailScreen> createState() => _CheckMailScreenState();
}

class _CheckMailScreenState extends State<CheckMailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      appBar: const CommonAppBar(),
      body: const SafeArea(top: false, child: WAuthPage(isShowIconRight: false, child: CheckEmailPage())),
    );
  }
}
