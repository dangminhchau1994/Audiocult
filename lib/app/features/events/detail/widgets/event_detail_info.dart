import 'package:audio_cult/app/data_source/models/responses/events/event_response.dart';
import 'package:audio_cult/app/utils/constants/app_assets.dart';
import 'package:audio_cult/app/utils/constants/app_dimens.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import '../../../../utils/constants/app_colors.dart';

class EventDetaiInfo extends StatelessWidget {
  const EventDetaiInfo({
    Key? key,
    this.data,
  }) : super(key: key);

  final EventResponse? data;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: kVerticalSpacing,
          horizontal: kHorizontalSpacing,
        ),
        child: Column(
          children: [
            _buildLocation(context, data!),
            const SizedBox(height: 30),
            _buildTime(context),
          ],
        ),
      ),
    );
  }

  Widget _buildLocation(BuildContext context, EventResponse data) {
    return Row(
      children: [
        SvgPicture.asset(
          AppAssets.locationIcon,
          width: 20,
          height: 20,
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            data.location ?? '',
            overflow: TextOverflow.ellipsis,
            style: context.bodyTextStyle()?.copyWith(
                  color: AppColors.subTitleColor,
                  fontSize: 14,
                ),
          ),
        ),
      ],
    );
  }

  String getEventTime(int index) {
    var date;
    var month;
    var year;
    var hour;

    if (data!.eventDate!.split('-')[1].contains(',')) {
      date = data?.eventDate?.split('-')[index].split(', ')[1].split(' ')[1];
      month = data?.eventDate?.split('-')[index].split(', ')[1].split(' ')[0];
      year = data?.eventDate?.split('-')[index].split(', ')[2].split(' ')[0];
      hour = DateFormat.jm().format(
        DateFormat('hh:mm').parse(data?.eventDate?.split('-')[index].split(', ')[2].split(' ')[1] ?? ''),
      );

      return '$month $date, $year at $hour';
    } else {
      return data!.eventDate!;
    }
  }

  Widget _buildTime(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(
          Icons.timelapse_outlined,
          color: Colors.white,
          size: 20,
        ),
        const SizedBox(width: 10),
        Text(
          data!.eventDate!.contains('-')
              ? data!.eventDate!.split('-')[1].contains(',')
                  ? '${getEventTime(0)}\n\n${getEventTime(1)}'
                  : getEventTime(0)
              : data!.eventDate!,
          style: context.bodyTextStyle()?.copyWith(
                color: AppColors.subTitleColor,
                fontSize: 14,
              ),
        )
      ],
    );
  }
}
