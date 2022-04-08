import 'package:audio_cult/app/constants/global_constants.dart';
import 'package:audio_cult/app/utils/constants/app_assets.dart';
import 'package:audio_cult/app/utils/constants/app_dimens.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:audio_cult/l10n/l10n.dart';
import 'package:audio_cult/w_components/dropdown/common_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../utils/constants/app_colors.dart';

class EventDetailAttending extends StatelessWidget {
  const EventDetailAttending({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: kHorizontalSpacing,
        vertical: kVerticalSpacing,
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: _buildComponent(
              Padding(
                padding: const EdgeInsets.only(
                  bottom: 10,
                  left: 30,
                ),
                child: SvgPicture.asset(
                  AppAssets.starIcon,
                ),
              ),
              CommonDropdown(
                hint: 'Attending',
                isBorderVisible: false,
                backgroundColor: Colors.transparent,
                data: GlobalConstants.getSelectedMenu(context),
              ),
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            flex: 2,
            child: _buildComponent(
              SvgPicture.asset(
                AppAssets.mailIcon,
              ),
              Text(
                context.l10n.t_invite_friend,
                style: context.bodyTextPrimaryStyle()!.copyWith(
                      color: Colors.white,
                      fontSize: 16,
                    ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildComponent(Widget icon, Widget child) {
    return Container(
      height: 70,
      decoration: BoxDecoration(
        color: AppColors.secondaryButtonColor,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          Expanded(flex: 2, child: icon),
          Expanded(flex: 4, child: child),
        ],
      ),
    );
  }
}
