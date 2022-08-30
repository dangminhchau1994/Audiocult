import 'package:audio_cult/app/utils/extensions/app_extensions.dart';

import 'package:flutter/material.dart';

import '../../../../utils/constants/app_colors.dart';

class StatusInput extends StatelessWidget {
  const StatusInput({
    Key? key,
    this.textEditingController,
    this.isAlignCenter,
    this.maxLine,
    this.onChanged,
  }) : super(key: key);

  final TextEditingController? textEditingController;
  final bool? isAlignCenter;
  final int? maxLine;
  final Function(String value)? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLines: maxLine,
      controller: textEditingController,
      textAlign: isAlignCenter! ? TextAlign.center : TextAlign.left,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(18),
        hintText: context.localize.t_what_new,
        hintStyle: context.bodyTextPrimaryStyle()!.copyWith(color: AppColors.subTitleColor, fontSize: 18),
        focusedBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
      ),
      onChanged: (value) {
        onChanged!(value);
      },
    );
  }
}
