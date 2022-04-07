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
      data: Theme.of(context).copyWith(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      child: CheckboxListTile(
        tristate: true,
        controlAffinity: ListTileControlAffinity.leading,
        title: Text(
          title ?? '',
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
