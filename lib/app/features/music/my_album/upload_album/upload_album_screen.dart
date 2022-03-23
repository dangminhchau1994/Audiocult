import 'package:audio_cult/app/features/music/my_album/upload_song/song_step1.dart';
import 'package:audio_cult/l10n/l10n.dart';
import 'package:flutter/material.dart';

import '../../../../../w_components/appbar/common_appbar.dart';
import '../../../../utils/constants/app_colors.dart';
import '../widgets/meta_data_step.dart';
import '../widgets/privacy_step.dart';
import '../widgets/stepper.dart';
import 'album_step2.dart';

class UploadAlbumScreen extends StatefulWidget {
  const UploadAlbumScreen({Key? key}) : super(key: key);

  @override
  State<UploadAlbumScreen> createState() => _UploadAlbumScreenState();
}

class _UploadAlbumScreenState extends State<UploadAlbumScreen> {
  int _currentStep = 1;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: CommonAppBar(
          title: context.l10n.t_create_album,
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
                  AlbumStep2(
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
