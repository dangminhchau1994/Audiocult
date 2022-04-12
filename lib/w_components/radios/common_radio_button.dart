import 'package:audio_cult/app/utils/constants/app_assets.dart';
import 'package:audio_cult/app/utils/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CommonRadioButton extends StatelessWidget {
  const CommonRadioButton({
    Key? key,
    this.onChanged,
    this.title,
    this.isSelected,
    this.index,
  }) : super(key: key);

  final Function(int index)? onChanged;
  final String? title;
  final int? index;
  final bool? isSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onChanged!(index ?? 0);
      },
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.inputFillColor,
              border: isSelected!
                  ? null
                  : Border.all(
                      color: AppColors.outlineBorderColor,
                      width: 2,
                    ),
            ),
            child: isSelected!
                ? SvgPicture.asset(AppAssets.activeRadio)
                : const SizedBox(
                    width: 16,
                    height: 16,
                  ),
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            title ?? '',
          )
        ],
      ),
    );
  }
}
