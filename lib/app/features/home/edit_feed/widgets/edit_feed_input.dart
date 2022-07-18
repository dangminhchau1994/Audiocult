import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:audio_cult/l10n/l10n.dart';
import 'package:flutter/material.dart';

import '../../../../utils/constants/app_colors.dart';

class EditFeedInput extends StatelessWidget {
  const EditFeedInput({
    Key? key,
    this.textEditingController,
    this.onChanged,
  }) : super(key: key);

  final TextEditingController? textEditingController;
  final Function(String value)? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: TextInputType.multiline,
      maxLines: null,
      controller: textEditingController,
      onChanged: onChanged,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(18),
        hintText: context.l10n.t_what_new,
        hintStyle: context.bodyTextPrimaryStyle()!.copyWith(color: AppColors.subTitleColor, fontSize: 18),
        focusedBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
      ),
    );
  }
}
