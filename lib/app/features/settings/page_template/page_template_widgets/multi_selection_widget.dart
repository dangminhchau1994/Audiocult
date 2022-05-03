import 'package:audio_cult/app/features/settings/page_template/page_template_widgets/page_template_widget.dart';
import 'package:audio_cult/w_components/textfields/common_input_tags_grid_checkbox.dart';
import 'package:flutter/material.dart';

class MultiSelectionWidget extends PageTemplateWidget {
  final List<InputTagSelect>? checkedTags;
  final List<InputTagSelect>? tags;
  final Function(InputTagSelect)? tagOnChanged;

  const MultiSelectionWidget(
    String title, {
    required this.tags,
    required this.checkedTags,
    this.tagOnChanged,
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
      padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
      child: CommonInputTagsGridCheckBox(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1 / .25,
        ),
        fillColor: Colors.transparent,
        isBorderVisible: false,
        initTags: checkedTags?.map((e) => e.title).toList() ?? [],
        onChange: (tag, isAdded) {
          if (!isAdded) return;
          tagOnChanged?.call(tag);
        },
        hintText: '',
        listCheckBox: tags ?? [],
        validator: false,
      ),
    );
  }
}
