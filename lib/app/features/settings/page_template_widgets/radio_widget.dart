import 'package:audio_cult/app/data_source/models/responses/page_template_response.dart';
import 'package:audio_cult/app/features/settings/page_template_widgets/page_template_widget.dart';
import 'package:audio_cult/w_components/radios/common_radio_button.dart';
import 'package:flutter/material.dart';

class RadioWidget extends PageTemplateWidget {
  final List<SelectableOption> options;
  final Function(SelectableOption)? onChanged;

  const RadioWidget(
    String title,
    this.options, {
    this.onChanged,
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
    return Column(children: [
      const SizedBox(height: 8),
      ..._options(),
      const SizedBox(height: 12),
    ]);
  }

  List<Widget> _options() {
    return options
        .map(
          (e) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            child: CommonRadioButton(
              isSelected: e.selected == true,
              title: e.value,
              onChanged: (_) => onChanged?.call(e),
            ),
          ),
        )
        .toList();
  }
}
