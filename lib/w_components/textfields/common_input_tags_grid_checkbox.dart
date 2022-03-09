import 'package:audio_cult/w_components/checkbox/common_checkbox.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../../libs/textfields_tags/lib/textfield_tags.dart';
import 'common_input_tags.dart';

class CommonInputTagsGridCheckBox extends StatefulWidget {
  final List<InputTagSelect> listCheckBox;
  final String? hintText;
  final List<String> initTags;
  final Function(InputTagSelect, bool isAdded)? onChange;
  const CommonInputTagsGridCheckBox({
    Key? key,
    required this.listCheckBox,
    this.hintText,
    this.onChange,
    required this.initTags,
  }) : super(key: key);

  @override
  State<CommonInputTagsGridCheckBox> createState() => _CommonInputTagsGridCheckBoxState();
}

class _CommonInputTagsGridCheckBoxState extends State<CommonInputTagsGridCheckBox> {
  final TextEditingController _controller = TextEditingController();
  bool isFocused = false;

  final GlobalKey<TextFieldTagsState> _myKey = GlobalKey();
  @override
  void initState() {
    super.initState();
    widget.initTags.removeWhere((element) => element.isEmpty);
  }

  @override
  void didUpdateWidget(covariant CommonInputTagsGridCheckBox oldWidget) {
    super.didUpdateWidget(oldWidget);
    widget.initTags.removeWhere((element) => element.isEmpty);
    if (widget.initTags.isEmpty) {
      _myKey.currentState?.clear();
    }
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
            initTags: widget.initTags,
            hintText: widget.hintText,
            controller: _controller,
            onChooseTag: (value) async {
              widget.onChange?.call(InputTagSelect(const Uuid().v4(), true, value), true);
            },
            onDeleteTag: (value) {
              widget.listCheckBox.map((e) {
                if (e.title == value) {
                  e.isSelected = false;
                }
              }).toList();
              widget.onChange?.call(InputTagSelect(const Uuid().v4(), false, value), true);

              setState(() {});
            },
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
                    widget.onChange?.call(widget.listCheckBox[index], false);
                  } else {
                    _myKey.currentState?.onDeleted(widget.listCheckBox[index].title);
                    widget.onChange?.call(widget.listCheckBox[index], false);
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
  String? id;
  // ignore: avoid_positional_boolean_parameters
  InputTagSelect(this.id, this.isSelected, this.title);
}
