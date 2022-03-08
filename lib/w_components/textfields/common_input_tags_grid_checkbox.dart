import 'package:audio_cult/w_components/checkbox/common_checkbox.dart';
import 'package:flutter/material.dart';

import '../../libs/textfields_tags/lib/textfield_tags.dart';
import 'common_input_tags.dart';

class CommonInputTagsGridCheckBox extends StatefulWidget {
  final List<InputTagSelect> listCheckBox;
  final String? hintText;
  const CommonInputTagsGridCheckBox({Key? key, required this.listCheckBox, this.hintText}) : super(key: key);

  @override
  State<CommonInputTagsGridCheckBox> createState() => _CommonInputTagsGridCheckBoxState();
}

class _CommonInputTagsGridCheckBoxState extends State<CommonInputTagsGridCheckBox> {
  final TextEditingController _controller = TextEditingController();
  bool isFocused = false;
  List<String> initTags = [];
  final GlobalKey<TextFieldTagsState> _myKey = GlobalKey();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Focus(
          onFocusChange: (hasFocus) {
            setState(() {
              isFocused = hasFocus;
            });
          },
          child: CommonInputTags(
            key: _myKey,
            initTags: initTags,
            hintText: widget.hintText,
            controller: _controller,
            onChooseTag: (value) async {},
            onDeleteTag: (value) {},
          ),
        ),
        if (!isFocused)
          const SizedBox.shrink()
        else
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: widget.listCheckBox.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 1 / .4,
            ),
            itemBuilder: (_, int index) {
              return CommonCheckbox(
                isChecked: widget.listCheckBox[index].isSelected,
                onChanged: (v) {
                  widget.listCheckBox[index].isSelected = v;
                  if (v) {
                    _myKey.currentState?.onSubmit(widget.listCheckBox[index].title);
                  } else {
                    _myKey.currentState?.onDeleted(widget.listCheckBox[index].title);
                  }
                  setState(() {});
                },
                title: widget.listCheckBox[index].title,
              );
            },
          )
      ],
    );
  }
}

class InputTagSelect {
  bool? isSelected;
  String title;
  // ignore: avoid_positional_boolean_parameters
  InputTagSelect(this.isSelected, this.title);
}
