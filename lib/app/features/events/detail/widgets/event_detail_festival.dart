import 'package:audio_cult/app/utils/constants/app_colors.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:audio_cult/l10n/l10n.dart';
import 'package:flutter/material.dart';

class EventDetailFestiVal extends StatelessWidget {
  const EventDetailFestiVal({
    Key? key,
    this.category,
  }) : super(key: key);

  final String? category;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 250,
      right: 25,
      child: category != null
          ? Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: AppColors.secondaryButtonColor,
              ),
              padding: const EdgeInsets.all(14),
              child: Text(
                category ?? '',
                style: context.bodyTextPrimaryStyle()!.copyWith(
                      color: AppColors.activeLabelItem,
                      fontSize: 16,
                    ),
              ),
            )
          : const SizedBox(),
    );
  }
}
