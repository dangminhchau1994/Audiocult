import 'package:audio_cult/app/features/events/create_event/widgets/insert_photo.dart';
import 'package:audio_cult/app/utils/constants/app_dimens.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:audio_cult/l10n/l10n.dart';
import 'package:audio_cult/w_components/textfields/common_chip_input.dart';
import 'package:audio_cult/w_components/textfields/common_input.dart';
import 'package:flutter/material.dart';

import '../../../../w_components/buttons/common_button.dart';
import '../../../utils/constants/app_colors.dart';

class SecondStepScreen extends StatelessWidget {
  const SecondStepScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: kHorizontalSpacing,
          vertical: kVerticalSpacing,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Description',
                style: context.bodyTextStyle()?.copyWith(color: Colors.white, fontSize: 18),
              ),
              const SizedBox(height: 10),
              Text(
                context.l10n.t_help_text,
                style: context.bodyTextStyle()?.copyWith(color: AppColors.subTitleColor, fontSize: 16),
              ),
              const SizedBox(height: 20),
              CommonInput(
                hintText: context.l10n.t_tags_event,
              ),
              const SizedBox(height: 20),
              const CommonInput(
                maxLine: 5,
                hintText: 'Description',
              ),
              const SizedBox(height: 20),
              const InsertPhoto(),
              const SizedBox(height: 30),
              Text(
                'Artist Lineup',
                style: context.bodyTextStyle()?.copyWith(color: Colors.white, fontSize: 18),
              ),
              const SizedBox(height: 10),
              CommonChipInput(
                hintText: context.l10n.t_artist_line_up_hint,
              ),
              const SizedBox(height: 20),
              Text(
                context.l10n.t_entertainment_line_up,
                style: context.bodyTextStyle()?.copyWith(color: Colors.white, fontSize: 18),
              ),
              const SizedBox(height: 10),
              CommonChipInput(
                hintText: context.l10n.t_artist_line_up_hint,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10, top: 40),
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: CommonButton(
                        color: AppColors.ebonyClay,
                        text: context.l10n.btn_back,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      flex: 2,
                      child: CommonButton(
                        color: AppColors.primaryButtonColor,
                        text: context.l10n.btn_next,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
