import 'package:audio_cult/app/data_source/models/requests/create_event_request.dart';
import 'package:audio_cult/app/utils/constants/app_dimens.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';

import 'package:flutter/material.dart';

import '../../../../w_components/buttons/common_button.dart';
import '../../../../w_components/textfields/common_input.dart';
import '../../../utils/constants/app_colors.dart';

class FourthStepScreen extends StatefulWidget {
  const FourthStepScreen({
    Key? key,
    this.onNext,
    this.onBack,
    this.createEventRequest,
  }) : super(key: key);

  final Function()? onNext;
  final Function()? onBack;
  final CreateEventRequest? createEventRequest;

  @override
  State<FourthStepScreen> createState() => _FourthStepScreenState();
}

class _FourthStepScreenState extends State<FourthStepScreen> {
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
                context.localize.t_add_host_detail,
                style: context.bodyTextStyle()?.copyWith(color: Colors.white, fontSize: 18),
              ),
              const SizedBox(height: 10),
              Text(
                context.localize.t_help_text,
                style: context.bodyTextStyle()?.copyWith(color: AppColors.subTitleColor, fontSize: 16),
              ),
              const SizedBox(height: 20),
              CommonInput(
                hintText: context.localize.t_host_name,
                onChanged: (value) {
                  widget.createEventRequest?.hostName = value;
                },
              ),
              const SizedBox(height: 20),
              CommonInput(
                hintText: 'Description',
                maxLine: 5,
                onChanged: (value) {
                  widget.createEventRequest?.hostDescription = value;
                },
              ),
              const SizedBox(height: 20),
              CommonInput(
                hintText: context.localize.t_host_website,
                onChanged: (value) {
                  widget.createEventRequest?.hostWebsite = value;
                },
              ),
              const SizedBox(height: 20),
              CommonInput(
                hintText: context.localize.t_host_facebook,
                onChanged: (value) {
                  widget.createEventRequest?.hostFacebook = value;
                },
              ),
              const SizedBox(height: 20),
              CommonInput(
                hintText: context.localize.t_host_twitter,
                onChanged: (value) {
                  widget.createEventRequest?.hostTwitter = value;
                },
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10, top: 40),
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: CommonButton(
                        color: AppColors.ebonyClay,
                        text: context.localize.btn_back,
                        onTap: widget.onBack,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      flex: 2,
                      child: CommonButton(
                        color: AppColors.primaryButtonColor,
                        text: context.localize.btn_next,
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
