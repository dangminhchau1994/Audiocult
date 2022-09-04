import 'package:audio_cult/app/utils/constants/app_dimens.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../w_components/buttons/w_button_inkwell.dart';
import '../../../../utils/constants/app_assets.dart';
import '../../../../utils/constants/app_colors.dart';
import '../../../../utils/route/app_route.dart';

class EventFilter extends StatelessWidget {
  const EventFilter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildListDelegate([
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: kHorizontalSpacing,
            vertical: kVerticalSpacing,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                context.localize.t_all_events,
                style: context.bodyTextStyle()?.copyWith(
                      color: Colors.white,
                    ),
              ),
              WButtonInkwell(
                onPressed: () {
                  Navigator.pushNamed(context, AppRoute.routeFilterEvent);
                },
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: AppColors.secondaryButtonColor,
                  ),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        AppAssets.filterIcon,
                        width: 20,
                        height: 20,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        context.localize.t_filter,
                        style: context.bodyTextStyle()?.copyWith(
                              color: Colors.white,
                            ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ]),
    );
  }
}
