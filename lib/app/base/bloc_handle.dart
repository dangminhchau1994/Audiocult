import 'package:audio_cult/app/data_source/networks/exceptions/no_internet_exception.dart';
import 'package:disposing/disposing.dart';
import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../w_components/loading/loading_widget.dart';
import '../utils/mixins/disposable_state_mixin.dart';
import '../utils/toast/toast_utils.dart';
import 'base_bloc.dart';

class BlocHandle extends StatefulWidget {
  final Widget child;
  final BaseBloc bloc;

  const BlocHandle({Key? key, required this.child, required this.bloc}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _BlocHandleState createState() => _BlocHandleState();
}

class _BlocHandleState extends State<BlocHandle> with DisposableStateMixin {
  @override
  void initState() {
    super.initState();
    _subscribe();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Future.value(!context.loaderOverlay.visible);
      },
      child: widget.child,
    );
  }

  void _subscribe() {
    widget.bloc.loadingStream.listen((isLoading) {
      if (isLoading) {
        context.loaderOverlay.show(
          widget: const LoadingWidget(
            backgroundColor: Colors.black12,
          ),
        );
      } else {
        context.loaderOverlay.hide();
      }
    }).disposeOn(disposeBag);

    widget.bloc.errorStream.listen((exception) async {
      if (exception is NoInternetException) {
        ToastUtility.showPending(context: context, message: exception.toString());
      } else {
        ToastUtility.showError(context: context, message: exception.toString());
      }
    }).disposeOn(disposeBag);
  }
}
