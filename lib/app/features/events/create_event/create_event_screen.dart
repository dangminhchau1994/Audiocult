import 'package:audio_cult/app/features/events/create_event/first_step_screen.dart';
import 'package:audio_cult/app/features/events/create_event/fourth_step_screen.dart';
import 'package:audio_cult/app/features/events/create_event/second_step_screen.dart';
import 'package:audio_cult/app/features/events/create_event/third_step_screen.dart';
import 'package:audio_cult/app/features/events/create_event/widgets/stepper_event.dart';
import 'package:audio_cult/app/features/music/my_album/upload_song/upload_song_bloc.dart';
import 'package:audio_cult/app/injections.dart';
import 'package:audio_cult/l10n/l10n.dart';
import 'package:audio_cult/w_components/appbar/common_appbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utils/constants/app_colors.dart';
import '../../music/my_album/widgets/privacy_step.dart';

class CreateEventScreen extends StatefulWidget {
  const CreateEventScreen({Key? key}) : super(key: key);

  @override
  State<CreateEventScreen> createState() => _CreateEventScreenState();
}

class _CreateEventScreenState extends State<CreateEventScreen> {
  int _currentStep = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      appBar: CommonAppBar(
        title: context.l10n.t_create_event,
      ),
      body: MultiProvider(
        providers: [
          Provider<UploadSongBloc>(create: (_) => UploadSongBloc(locator.get(), locator.get())),
        ],
        child: Column(
          children: [
            StepperEvent(
              currentStep: _currentStep,
            ),
            Expanded(
              child: IndexedStack(
                index: _currentStep - 1,
                children: [
                  PrivacyStep(),
                ],
              ),
            ),
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
}
