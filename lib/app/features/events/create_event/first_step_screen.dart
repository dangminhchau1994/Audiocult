import 'package:audio_cult/app/constants/global_constants.dart';
import 'package:audio_cult/app/features/events/create_event/widgets/event_datetime_field.dart';
import 'package:audio_cult/app/utils/constants/app_dimens.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:audio_cult/l10n/l10n.dart';
import 'package:audio_cult/w_components/buttons/common_button.dart';
import 'package:audio_cult/w_components/dropdown/common_dropdown.dart';
import 'package:audio_cult/w_components/textfields/common_input.dart';
import 'package:flutter/material.dart';
import '../../../utils/constants/app_colors.dart';

class FirstStepScreen extends StatefulWidget {
  const FirstStepScreen({Key? key}) : super(key: key);

  @override
  State<FirstStepScreen> createState() => _FirstStepScreenState();
}

class _FirstStepScreenState extends State<FirstStepScreen> {
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.l10n.t_main_info,
              style: context.bodyTextStyle()?.copyWith(color: Colors.white, fontSize: 18),
            ),
            const SizedBox(height: 20),
            Text(
              context.l10n.t_please_fill,
              style: context.bodyTextStyle()?.copyWith(
                    color: AppColors.subTitleColor,
                  ),
            ),
            const SizedBox(height: 20),
            CommonInput(
              hintText: context.l10n.t_event_title,
            ),
            const SizedBox(height: 20),
            CommonDropdown(
              hint: context.l10n.t_category,
              data: GlobalConstants.getSelectedMenu(context),
            ),
            const SizedBox(height: 20),
            CommonInput(
              hintText: context.l10n.t_location_venue,
            ),
            const SizedBox(height: 20),
            Text(
              context.l10n.t_start_time,
              style: context.bodyTextStyle()?.copyWith(color: Colors.white, fontSize: 18),
            ),
            const SizedBox(height: 20),
            const EventDateTimeField(),
            const SizedBox(height: 20),
            Text(
              context.l10n.t_end_time,
              style: context.bodyTextStyle()?.copyWith(color: Colors.white, fontSize: 18),
            ),
            const SizedBox(height: 20),
            const EventDateTimeField(),
            Expanded(
              child: Align(
                alignment: FractionalOffset.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: CommonButton(
                    color: AppColors.primaryButtonColor,
                    text: context.l10n.btn_next,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
