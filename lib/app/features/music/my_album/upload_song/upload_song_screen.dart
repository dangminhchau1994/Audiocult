import 'package:audio_cult/app/base/bloc_handle.dart';
import 'package:audio_cult/app/features/music/my_album/upload_song/song_step1.dart';
import 'package:audio_cult/app/features/music/my_album/upload_song/song_step2.dart';
import 'package:audio_cult/app/features/music/my_album/upload_song/upload_song_bloc.dart';
import 'package:audio_cult/app/features/music/my_album/widgets/meta_data_step.dart';
import 'package:audio_cult/app/features/music/my_album/widgets/privacy_step.dart';
import 'package:audio_cult/app/injections.dart';
import 'package:audio_cult/app/utils/constants/app_colors.dart';
import 'package:audio_cult/app/utils/mixins/disposable_state_mixin.dart';
import 'package:audio_cult/app/utils/toast/toast_utils.dart';
import 'package:audio_cult/l10n/l10n.dart';
import 'package:audio_cult/w_components/appbar/common_appbar.dart';
import 'package:disposing/disposing.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../../data_source/models/responses/album/album_response.dart';
import '../../../../data_source/models/responses/song/song_response.dart';
import '../widgets/stepper.dart';

class UploadSongScreen extends StatefulWidget {
  final Map<String, dynamic> params;

  const UploadSongScreen({Key? key, required this.params}) : super(key: key);

  @override
  State<UploadSongScreen> createState() => _UploadSongScreenState();
  static Map<String, dynamic> createArguments(
          {required bool isUploadSong, required Song? song, required Album? album}) =>
      {'isUploadSong': isUploadSong, 'song': song, 'album': album};
}

class _UploadSongScreenState extends State<UploadSongScreen> with DisposableStateMixin {
  int _currentStep = 1;
  final UploadSongBloc _uploadSongBloc = UploadSongBloc(locator.get(), locator.get());
  final GlobalKey<SongStep1State> _keyStep1 = GlobalKey();
  final GlobalKey<SongStep2State> _keyStep2 = GlobalKey();
  final GlobalKey<PrivacyStepState> _keyStep3 = GlobalKey();
  final GlobalKey<MetaDataStepState> _keyStep4 = GlobalKey();
  bool? isUploadSong;
  Song? _song;
  Album? _album;
  @override
  void initState() {
    super.initState();
    isUploadSong = widget.params['isUploadSong'] as bool?;
    _song = widget.params['song'] as Song?;
    _album = widget.params['album'] as Album?;
    _uploadSongBloc.uploadStream.listen((event) {
      ToastUtility.showSuccess(context: context, message: event);
      Navigator.pop(context, true);
    }).disposeOn(disposeBag);
  }

  @override
  Widget build(BuildContext context) {
    return Provider<UploadSongBloc>(
      create: (context) => _uploadSongBloc,
      dispose: (context, bloc) => bloc.dispose(),
      child: BlocHandle(
        bloc: _uploadSongBloc,
        child: SafeArea(
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
                        key: _keyStep1,
                        onNext: onNext,
                        song: _song,
                        album: _album,
                      ),
                      SongStep2(
                        song: _song,
                        album: _album,
                        key: _keyStep2,
                        isUploadSong: isUploadSong,
                        onBack: onBack,
                        onNext: onNext,
                      ),
                      PrivacyStep(
                        key: _keyStep3,
                        onBack: onBack,
                        onNext: onNext,
                      ),
                      MetaDataStep(
                        song: _song,
                        key: _keyStep4,
                        album: _album,
                        onBack: onBack,
                        onCompleted: onCompleted,
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
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

  void onCompleted() {
    if (_song == null && _album == null) {
      //add new
      final resultStep2 = _keyStep2.currentState!.getValue;
      final resultStep1 = _keyStep1.currentState!.listFileAudio;
      final resultStep4 = _keyStep4.currentState!.getValue;
      resultStep2.isFree = resultStep4.isFree;
      resultStep2.cost = resultStep4.cost;
      resultStep2.licenseType = resultStep4.licenseType;
      resultStep2.audioFile = XFile(resultStep1[0].first.path!, name: resultStep1[0].first.name);
      if (isUploadSong!) {
        _uploadSongBloc.uploadSong(resultStep2);
      } else {
        _uploadSongBloc.uploadAlbum(resultStep2);
      }
    } else {
      final resultStep2 = _keyStep2.currentState!.getValue;
      final resultStep4 = _keyStep4.currentState!.getValue;
      resultStep2.isFree = resultStep4.isFree;
      resultStep2.cost = resultStep4.cost;
      resultStep2.licenseType = resultStep4.licenseType;

      resultStep2.albumId = _album?.albumId;
      //edit
      if (isUploadSong!) {
        print('edit song');
      } else {
        _uploadSongBloc.editAlbum(resultStep2);
      }
    }
  }
}
