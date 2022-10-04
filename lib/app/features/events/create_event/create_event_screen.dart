import 'package:audio_cult/app/data_source/models/requests/create_event_request.dart';
import 'package:audio_cult/app/features/events/create_event/create_event_bloc.dart';
import 'package:audio_cult/app/features/events/create_event/fifth_step_screen.dart';
import 'package:audio_cult/app/features/events/create_event/first_step_screen.dart';
import 'package:audio_cult/app/features/events/create_event/fourth_step_screen.dart';
import 'package:audio_cult/app/features/events/create_event/second_step_screen.dart';
import 'package:audio_cult/app/features/events/create_event/third_step_screen.dart';
import 'package:audio_cult/app/features/events/create_event/widgets/stepper_event.dart';
import 'package:audio_cult/app/features/music/my_album/upload_song/upload_song_bloc.dart';
import 'package:audio_cult/app/injections.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:audio_cult/app/utils/toast/toast_utils.dart';

import 'package:audio_cult/w_components/appbar/common_appbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../w_components/error_empty/error_section.dart';
import '../../../../w_components/loading/loading_blur.dart';
import '../../../base/bloc_state.dart';
import '../../../data_source/models/responses/events/event_response.dart';
import '../../../utils/constants/app_colors.dart';

class CreateEventScreen extends StatefulWidget {
  final EventResponse? event;

  const CreateEventScreen({this.event, Key? key}) : super(key: key);

  @override
  State<CreateEventScreen> createState() => _CreateEventScreenState();
}

class _CreateEventScreenState extends State<CreateEventScreen> {
  final CreateEventBloc _createEventBloc = CreateEventBloc(locator.get());
  var _currentStep = 1;
  late CreateEventRequest _createEventRequest;
  var _runStream = false;

  @override
  void initState() {
    super.initState();
    _createEventRequest = CreateEventRequest.initFromEventResponse(eventResponse: widget.event);
    _createEventBloc.editEventStream.listen((event) {
      event.when(
        success: (event) {
          setState(() {
            _runStream = false;
          });
          ToastUtility.showSuccess(context: context);
          Navigator.pop(context, event);
        },
        loading: () {},
        error: (e) {
          setState(() {
            _runStream = false;
          });
          ToastUtility.showError(context: context, message: e);
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      appBar: CommonAppBar(
        title: _createEventRequest.isEditing ? context.localize.t_edit_event : context.localize.t_create_event,
      ),
      body: MultiProvider(
        providers: [
          Provider<UploadSongBloc>(create: (_) => UploadSongBloc(locator.get(), locator.get())),
          Provider<CreateEventBloc>(create: (_) => _createEventBloc),
        ],
        child: Stack(
          children: [
            Column(
              children: [
                StepperEvent(
                  currentStep: _currentStep,
                ),
                Expanded(
                  child: IndexedStack(
                    index: _currentStep - 1,
                    children: [
                      FirstStepScreen(
                        onNext: onNext,
                        createEventRequest: _createEventRequest,
                      ),
                      SecondStepScreen(
                        onNext: onNext,
                        onBack: onBack,
                        createEventRequest: _createEventRequest,
                      ),
                      ThirdStepScreen(
                        onNext: onNext,
                        onBack: onBack,
                        createEventRequest: _createEventRequest,
                      ),
                      FourthStepScreen(
                        onNext: onNext,
                        onBack: onBack,
                        createEventRequest: _createEventRequest,
                      ),
                      FifthStepScreen(
                        onBack: onBack,
                        onComplete: onComplete,
                        createEventRequest: _createEventRequest,
                      )
                    ],
                  ),
                ),
              ],
            ),
            if (_runStream)
              StreamBuilder<BlocState<EventResponse>>(
                initialData: const BlocState.loading(),
                stream: _createEventBloc.createEventStream,
                builder: (context, snapshot) {
                  final state = snapshot.data!;

                  return state.when(
                    success: (data) {
                      Navigator.pop(context, true);
                      return Container();
                    },
                    loading: () {
                      return const Center(
                        child: LoadingBlur(),
                      );
                    },
                    error: (error) {
                      return ErrorSectionWidget(
                        errorMessage: error,
                        onRetryTap: () {
                          _createEventBloc.completeInputEventData(_createEventRequest);
                        },
                      );
                    },
                  );
                },
              )
            else
              const SizedBox()
          ],
        ),
      ),
    );
  }

  void onComplete() {
    setState(() {
      _runStream = true;
      _createEventBloc.completeInputEventData(_createEventRequest);
    });
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
