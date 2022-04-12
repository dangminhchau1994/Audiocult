import 'package:audio_cult/app/utils/constants/app_assets.dart';
import 'package:audio_cult/app/utils/constants/app_colors.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:audio_cult/app/utils/file/file_utils.dart';
import 'package:audio_cult/app/utils/route/app_route.dart';
import 'package:audio_cult/l10n/l10n.dart';
import 'package:audio_cult/w_components/buttons/w_button_inkwell.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ShowEvents extends StatelessWidget {
  const ShowEvents({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.l10n.t_show_events,
          style: context.bodyTextStyle()?.copyWith(
                color: AppColors.subTitleColor.withOpacity(0.7),
              ),
        ),
        const SizedBox(
          height: 14,
        ),
        Row(
          children: [
            WButtonInkwell(
              onPressed: () {
                Navigator.pushNamed(context, AppRoute.routeCalendarEvent);
              },
              child: _buildButton(
                AppAssets.calendarIcon,
                context.l10n.t_in_calendar,
                context,
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            WButtonInkwell(
              onPressed: () async {
                await Navigator.pushNamed(
                  context,
                  AppRoute.routeEventMap,
                );
              },
              child: _buildButton(
                AppAssets.locationIcon,
                context.l10n.t_on_map,
                context,
              ),
            ),
          ],
        )
      ],
    );
  }

  Widget _buildButton(String icon, String title, BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: AppColors.secondaryButtonColor,
      ),
      child: Row(
        children: [
          SvgPicture.asset(
            icon,
            width: 20,
            height: 20,
          ),
          const SizedBox(
            width: 8,
          ),
          Text(
            title,
            style: context.bodyTextStyle()?.copyWith(
                  color: Colors.white,
                ),
          ),
        ],
      ),
    );
  }
}
