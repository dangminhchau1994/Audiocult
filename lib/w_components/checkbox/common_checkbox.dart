import 'package:audio_cult/app/constants/app_text_styles.dart';
import 'package:flutter/material.dart';

import '../../app/utils/constants/app_colors.dart';

class CommonCheckbox extends StatelessWidget {
  const CommonCheckbox({
    Key? key,
    this.title,
    this.isChecked,
    this.onChanged,
  }) : super(key: key);

  final String? title;
  final Function(bool value)? onChanged;
  final bool? isChecked;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      child: CheckboxListTile(
        tristate: true,
        controlAffinity: ListTileControlAffinity.leading,
        title: Text(
          title ?? '',
          style: AppTextStyles.regular,
        ),
        activeColor: AppColors.primaryButtonColor,
        value: isChecked,
        side: BorderSide(
          color: AppColors.outlineBorderColor,
          width: 2,
        ),
        onChanged: (value) {
          onChanged!(value ?? false);
        },
      ),
    );
  }
}