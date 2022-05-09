import 'package:audio_cult/app/features/settings/page_template_widgets/page_template_widget.dart';
import 'package:audio_cult/w_components/dropdown/common_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

class SingleSelectionWidget extends PageTemplateWidget {
  final List<SelectMenuModel> options;
  final Function(SelectMenuModel)? onSelected;

  const SingleSelectionWidget(String title, this.options, {this.onSelected, Key? key}) : super(title, key: key);

  @override
  Widget build(BuildContext context) {
    return _body(context);
  }

  Widget _body(BuildContext context) {
    return super.build(context);
  }

  @override
  Widget content() {
    return CommonDropdown(
      backgroundColor: Colors.transparent,
      isBorderVisible: false,
      selection: options.firstWhereOrNull((element) => element.isSelected),
      onChanged: (value) => onSelected?.call(value!),
      onTap: () {},
      data: options,
      hint: '',
    );
  }
}
