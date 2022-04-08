import 'package:audio_cult/app/utils/constants/app_colors.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:audio_cult/l10n/l10n.dart';
import 'package:flutter/material.dart';

class EventDetailFestiVal extends StatelessWidget {
  const EventDetailFestiVal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 276,
      right: 25,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: AppColors.secondaryButtonColor,
        ),
        padding: const EdgeInsets.all(14),
        child: Text(
          context.l10n.t_festival,
          style: context.bodyTextPrimaryStyle()!.copyWith(
                color: AppColors.activeLabelItem,
                fontSize: 16,
              ),
        ),
      ),
    );
  }
}
