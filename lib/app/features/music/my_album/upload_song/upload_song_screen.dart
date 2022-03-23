import 'package:audio_cult/app/features/music/my_album/upload_song/song_step1.dart';
import 'package:audio_cult/app/features/music/my_album/upload_song/song_step2.dart';
import 'package:audio_cult/app/features/music/my_album/widgets/meta_data_step.dart';
import 'package:audio_cult/app/features/music/my_album/widgets/privacy_step.dart';
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
  int _currentStep = 3;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: CommonAppBar(
          title: context.l10n.t_upload_song,
          backgroundColor: AppColors.mainColor,
        ),
        backgroundColor: AppColors.mainColor,
        body: Column(
          children: [
            StepperUpload(currentStep: _currentStep),
            Expanded(
              child: IndexedStack(
                index: _currentStep - 1,
                children: [
                  SongStep1(
                    onNext: onNext,
                  ),
                  SongStep2(
                    onBack: onBack,
                    onNext: onNext,
                  ),
                  PrivacyStep(
                    onBack: onBack,
                    onNext: onNext,
                  ),
                  MetaDataStep(
                    onBack: onBack,
                    onCompleted: onCompleted,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void onNext() {
    setState(() {
      _currentStep++;
    });
  }

  void onBack() {
    setState(() {
      _currentStep--;
    });
  }

  void onCompleted() {}
}
