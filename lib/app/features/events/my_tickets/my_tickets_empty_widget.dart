import 'package:audio_cult/app/utils/constants/app_assets.dart';
import 'package:audio_cult/app/utils/constants/app_colors.dart';
import 'package:audio_cult/app/utils/constants/app_dimens.dart';
import 'package:audio_cult/app/utils/constants/app_font_sizes.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:audio_cult/w_components/buttons/common_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MyTicketsEmptyWidget extends StatelessWidget {
  final VoidCallback action;

  const MyTicketsEmptyWidget(this.action, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      slivers: [
        SliverFillRemaining(
          hasScrollBody: false,
          child: _body(context),
        ),
      ],
    );
  }

  Widget _body(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          AppAssets.eventIcon,
          width: 50,
        ),
        const SizedBox(height: kVerticalSpacing),
        Text(
          context.localize.t_no_ticket_yet,
          style: context.body3TextStyle()?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: AppFontSize.size19,
              ),
        ),
        const SizedBox(height: 16),
        Text(
          context.localize.t_attend_first_event,
          style: context.body3TextStyle(),
        ),
        const SizedBox(height: 40),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 100),
          child: CommonButton(
            color: AppColors.persianGreen,
            text: context.localize.t_go_to_popular_events,
            onTap: action.call,
          ),
        ),
      ],
    );
  }
}
