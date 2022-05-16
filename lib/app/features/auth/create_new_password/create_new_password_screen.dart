import 'package:audio_cult/app/features/auth/widgets/w_auth_page.dart';
import 'package:audio_cult/app/utils/constants/app_colors.dart';
import 'package:flutter/material.dart';

import '../../../../w_components/appbar/common_appbar.dart';
import '../widgets/create_new_password.dart';

class CreateNewPasswordScreen extends StatefulWidget {
  const CreateNewPasswordScreen({Key? key}) : super(key: key);

  @override
  State<CreateNewPasswordScreen> createState() => _CreateNewPasswordScreenState();
}

class _CreateNewPasswordScreenState extends State<CreateNewPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      appBar: const CommonAppBar(),
      body: SafeArea(
        top: false,
        child: WAuthPage(
            isHideHeader: MediaQuery.of(context).viewInsets.bottom > 0,
            isShowIconRight: false,
            child: const CreateNewPasswordPage()),
      ),
    );
  }
}
