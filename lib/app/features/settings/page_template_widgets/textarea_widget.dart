import 'package:audio_cult/app/features/settings/page_template_widgets/page_template_widget.dart';
import 'package:flutter/material.dart';

class TextareaWidget extends PageTemplateWidget {
  final String initialText;
  final Function(String) onChanged;

  const TextareaWidget(
    String title, {
    required this.initialText,
    required this.onChanged,
    Key? key,
  }) : super(title, key: key);

  @override
  Widget build(BuildContext context) {
    return _body(context);
  }

  Widget _body(BuildContext context) {
    return super.build(context);
  }

  @override
  Widget content() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: TextField(
        onChanged: onChanged,
        controller: TextEditingController()..text = initialText,
        minLines: 3,
        maxLines: null,
        keyboardType: TextInputType.multiline,
        decoration: const InputDecoration(
          border: OutlineInputBorder(borderSide: BorderSide.none),
          hintText: '...',
        ),
      ),
    );
  }
}
