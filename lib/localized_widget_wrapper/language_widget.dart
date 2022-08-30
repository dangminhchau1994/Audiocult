import 'package:audio_cult/app/injections.dart';
import 'package:audio_cult/localized_widget_wrapper/language_bloc.dart';
import 'package:flutter/widgets.dart';

class LanguageWidget extends StatefulWidget {
  final Widget Function(BuildContext) builder;

  const LanguageWidget({required this.builder, Key? key}) : super(key: key);

  @override
  State<LanguageWidget> createState() => _LanguageWidgetState();
}

class _LanguageWidgetState extends State<LanguageWidget> {
  final _bloc = locator<LanguageBloc>();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _bloc.localizeStream,
      builder: (_, snapshot) {
        return LayoutBuilder(builder: (context, __) {
          return widget.builder(context);
        });
      },
    );
  }
}
