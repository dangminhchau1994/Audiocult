import 'package:audio_cult/app/constants/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:textfield_tags/textfield_tags.dart';

import '../../app/utils/constants/app_colors.dart';

class CommonInputTags extends StatelessWidget {
  const CommonInputTags({
    Key? key,
    this.onChooseTag,
    this.onDeleteTag,
  }) : super(key: key);

  final Function(String tag)? onChooseTag;
  final Function(String tag)? onDeleteTag;

  @override
  Widget build(BuildContext context) {
    return TextFieldTags(
      tagsStyler: TagsStyler(
        tagTextStyle: AppTextStyles.regular.copyWith(
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
        hintText: 'Enter tags',
        textStyle: AppTextStyles.regular,
        hintStyle: AppTextStyles.regular,
        textFieldFilledColor: AppColors.inputFillColor,
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
