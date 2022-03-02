import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:flutter/material.dart';

import '../../../../utils/constants/app_colors.dart';

class SectionTitle extends StatelessWidget {
  const SectionTitle({
    Key? key,
    this.title,
    this.onShowAll,
  }) : super(key: key);

  final String? title;
  final Function()? onShowAll;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title ?? '',
          style: context.buttonTextStyle()!.copyWith(
                fontSize: 18,
              ),
        ),
        GestureDetector(
          onTap: onShowAll,
          child: Text(
            'Show All',
            style: context.bodyTextPrimaryStyle()!.copyWith(
                  fontSize: 16,
                  color: AppColors.lightBlue,
                ),
          ),
        ),
      ],
    );
  }
}
