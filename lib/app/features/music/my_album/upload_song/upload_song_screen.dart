import 'package:audio_cult/app/utils/constants/app_colors.dart';
import 'package:audio_cult/l10n/l10n.dart';
import 'package:audio_cult/w_components/appbar/common_appbar.dart';
import 'package:flutter/material.dart';

import '../widgets/stepper.dart';

class UploadSongScreen extends StatefulWidget {
  const UploadSongScreen({Key? key}) : super(key: key);

  @override
  State<UploadSongScreen> createState() => _UploadSongScreenState();
}

class _UploadSongScreenState extends State<UploadSongScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        title: context.l10n.t_upload_song,
        backgroundColor: AppColors.mainColor,
      ),
      backgroundColor: AppColors.mainColor,
      body: Column(
        children: [StepperUpload()],
      ),
    );
  }
}
