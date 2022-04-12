import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:audio_cult/libs/textfields_tags/lib/textfield_tags.dart';
import 'package:flutter/material.dart';

import '../../app/utils/constants/app_colors.dart';

class CommonInputTags extends StatelessWidget {
  const CommonInputTags({Key? key, this.onChooseTag, this.onDeleteTag, this.controller, this.initTags, this.hintText})
      : super(key: key);

  final Function(String tag)? onChooseTag;
  final Function(String tag)? onDeleteTag;
  final List<String>? initTags;
  final TextEditingController? controller;
  final String? hintText;

  @override
  Widget build(BuildContext context) {
    return TextFieldTags(
      key: key,
      initialTags: initTags,
      textEditingController: controller ?? TextEditingController(),
      tagsStyler: TagsStyler(
        tagTextStyle: context.bodyTextStyle()?.copyWith(
              fontWeight: FontWeight.bold,
            ),
        tagDecoration: BoxDecoration(
          color: AppColors.primaryButtonColor,
          borderRadius: BorderRadius.circular(12),
        ),
        tagCancelIcon: const Padding(
          padding: EdgeInsets.only(left: 4),
          child: Icon(
            Icons.close,
            size: 14,
            color: Colors.white,
          ),
        ),
        tagPadding: const EdgeInsets.all(6),
      ),
      textFieldStyler: TextFieldStyler(
        cursorColor: Colors.white,
        textFieldFilled: true,
        hintText: hintText ?? '',
        helperText: '',
        textStyle: const TextStyle(
          color: Colors.white,
        ),
        textFieldFilledColor: AppColors.inputFillColor.withOpacity(0.4),
        textFieldEnabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide(
            color: AppColors.outlineBorderColor,
            width: 2,
          ),
        ),
        textFieldFocusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide(
            color: AppColors.outlineBorderColor,
            width: 2,
          ),
        ),
      ),
      onTag: onChooseTag!,
      onDelete: onDeleteTag!,
      validator: (tag) {
        if (tag.length > 15) {
          return "hey that's too long";
        } else if (tag.isEmpty) {
          return 'please enter tag';
        }
        return null;
      },
    );
  }
}
