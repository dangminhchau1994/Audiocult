import 'package:audio_cult/app/injections.dart';
import 'package:flutter/material.dart';
import '../../app/base/base_bloc.dart';
import '../../app/base/state.dart';
import '../error_empty/error_section.dart';
import '../error_empty/widget_state.dart';
import 'loading_widget.dart';

class LoadingBuilder<T extends BaseBloc, TModel> extends StatefulWidget {
  final Widget Function(TModel data, dynamic params) builder;
  final Widget Function()? errorBuilder;
  final Widget Function(dynamic state)? noDataBuilder;
  final Widget Function()? initBuilder;
  final Widget Function()? loadingBuilder;
  final Function(dynamic params)? reloadAction;

  // ignore: use_key_in_widget_constructors
  const LoadingBuilder(
      {required this.builder,
      this.errorBuilder,
      this.initBuilder,
      this.noDataBuilder,
      this.loadingBuilder,
      this.reloadAction,});

  @override
  // ignore: library_private_types_in_public_api
  _LoadingBuilderState<T, TModel> createState() => _LoadingBuilderState<T, TModel>();
}

class _LoadingBuilderState<T extends BaseBloc, TModel> extends State<LoadingBuilder<T, TModel>> {
  late T bloc;
  @override
  void initState() {
    super.initState();
    bloc = locator.get<T>();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      initialData: InitialState(),
      stream: bloc.appStream,
      builder: (context, snapshot) {
        final state = snapshot.data;
        if (state is InitialState) {
          return widget.initBuilder != null ? widget.initBuilder!() : Container();
        } else if (state is LoadingState) {
          return widget.loadingBuilder != null
              ? widget.loadingBuilder!()
              : Container(
                  alignment: Alignment.center,
                  constraints: const BoxConstraints(minHeight: 50),
                  child: const LoadingWidget(),
                );
        } else if (state is ErrorState) {
          debugPrint('chauDang: ${state.message}');
          return widget.errorBuilder != null
              ? widget.errorBuilder!()
              : LayoutBuilder(
                  builder: (context, constraints) => SizedBox(
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: SizedBox(
                        height: constraints.maxHeight,
                        child: ErrorSectionWidget(
                          errorMessage: state.message ?? 'Unknown error!',
                          onRetryTap: () => widget.reloadAction?.call(state.params),
                        ),
                      ),
                    ),
                  ),
                );
        } else if (state is EmptyDataState) {
          return widget.noDataBuilder != null
              ? widget.noDataBuilder!(state.params)
              : LayoutBuilder(
                  builder: (context, constraints) => SizedBox(
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: SizedBox(
                        height: constraints.maxHeight,
                        child: EmptyDataStateWidget(state.message),
                      ),
                    ),
                  ),
                );
        }
        // ignore: cast_nullable_to_non_nullable
        return widget.builder((state as DataLoadedState).data as TModel, state.params);
      },
    );
  }
}
