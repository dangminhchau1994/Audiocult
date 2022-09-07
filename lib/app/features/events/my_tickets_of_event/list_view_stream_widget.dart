import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:audio_cult/w_components/loading/loading_widget.dart';
import 'package:flutter/material.dart';

class ListViewStreamWidget<T extends List> extends StatefulWidget {
  final Stream<T> stream;
  final Widget? placeholder;
  final Widget? error;
  final Widget Function(BuildContext, T) itemBuilder;

  const ListViewStreamWidget(
    this.stream,
    this.itemBuilder, {
    this.placeholder,
    this.error,
    Key? key,
  }) : super(key: key);

  @override
  State<ListViewStreamWidget<T>> createState() => _ListViewStreamWidgetState<T>();
}

class _ListViewStreamWidgetState<T extends List> extends State<ListViewStreamWidget<T>> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<T>(
      stream: widget.stream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: widget.error ?? Text(snapshot.error.toString()));
        }
        if (!snapshot.hasData) {
          return const LoadingWidget();
        } else if (snapshot.hasData) {
          if (snapshot.data?.isNotEmpty == true) {
            final data = snapshot.data!;
            return widget.itemBuilder(context, data);
          }
        }
        return widget.placeholder ?? Center(child: Text(context.localize.t_no_results_found));
      },
    );
  }
}
