import 'package:audio_cult/app/features/events/all_events/widgets/all_event_item.dart';
import 'package:audio_cult/app/utils/constants/app_assets.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:audio_cult/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../utils/constants/app_colors.dart';

class AllEvents extends StatefulWidget {
  const AllEvents({Key? key}) : super(key: key);

  @override
  State<AllEvents> createState() => _AllEventsState();
}

class _AllEventsState extends State<AllEvents> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 150),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                context.l10n.t_all_events,
                style: context.bodyTextStyle()?.copyWith(
                      color: Colors.white,
                      fontSize: 14,
                    ),
              ),
              Container(
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
                      'Filter',
                      style: context.bodyTextStyle()?.copyWith(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                    ),
                  ],
                ),
              )
            ],
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 500,
            child: ListView.separated(
              shrinkWrap: true,
              itemBuilder: (context, index) => const AllEventItem(),
              separatorBuilder: (context, index) => const SizedBox(height: 20),
              itemCount: 10,
            ),
          )
        ],
      ),
    );
  }
}
