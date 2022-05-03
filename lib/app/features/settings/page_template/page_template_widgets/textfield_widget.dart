import 'package:audio_cult/app/features/settings/page_template/page_template_widgets/page_template_widget.dart';
import 'package:audio_cult/w_components/textfields/common_input.dart';
import 'package:flutter/material.dart';

class TextfieldWidget extends PageTemplateWidget {
  final Function(String)? onChanged;

  const TextfieldWidget(String title, {this.onChanged, Key? key}) : super(title, key: key);

  @override
  Widget build(BuildContext context) {
    return _body(context);
  }

  Widget _body(BuildContext context) {
    return super.build(context);
  }

  @override
  Widget content() {
    return CommonInput(
      onChanged: onChanged,
      hintText: '...',
      fillColor: Colors.transparent,
      isBorderVisible: false,
    );
  }
}
