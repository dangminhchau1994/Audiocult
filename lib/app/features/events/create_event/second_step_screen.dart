import 'dart:convert';

import 'package:audio_cult/app/features/events/create_event/widgets/insert_photo.dart';
import 'package:audio_cult/app/utils/constants/app_dimens.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:audio_cult/l10n/l10n.dart';
import 'package:audio_cult/w_components/textfields/common_chip_input.dart';
import 'package:audio_cult/w_components/textfields/common_input.dart';
import 'package:flutter/material.dart';

import '../../../../w_components/buttons/common_button.dart';
import '../../../data_source/models/requests/create_event_request.dart';
import '../../../utils/constants/app_colors.dart';

class SecondStepScreen extends StatefulWidget {
  const SecondStepScreen({
    Key? key,
    this.onNext,
    this.onBack,
    this.createEventRequest,
  }) : super(key: key);

  final Function()? onNext;
  final Function()? onBack;
  final CreateEventRequest? createEventRequest;

  @override
  State<SecondStepScreen> createState() => _SecondStepScreenState();
}

class _SecondStepScreenState extends State<SecondStepScreen> {
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
                onChanged: (value) {
                  widget.createEventRequest?.tags = value;
                },
              ),
              const SizedBox(height: 20),
              CommonInput(
                maxLine: 5,
                hintText: 'Description',
                onChanged: (value) {
                  widget.createEventRequest?.description = value;
                },
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
                maxChip: 10,
                fromEvent: true,
                onChooseMultipleTag: (value) {
                  widget.createEventRequest?.artist = jsonEncode(value);
                },
                onDeleteTag: (value) {},
              ),
              const SizedBox(height: 20),
              Text(
                context.l10n.t_entertainment_line_up,
                style: context.bodyTextStyle()?.copyWith(color: Colors.white, fontSize: 18),
              ),
              const SizedBox(height: 10),
              CommonChipInput(
                hintText: context.l10n.t_artist_line_up_hint,
                maxChip: 10,
                fromEvent: true,
                onChooseMultipleTag: (value) {},
                onDeleteTag: (value) {},
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
                        onTap: widget.onBack,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      flex: 2,
                      child: CommonButton(
                        color: AppColors.primaryButtonColor,
                        text: context.l10n.btn_next,
                        onTap: () {
                          widget.onNext!();
                        },
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
