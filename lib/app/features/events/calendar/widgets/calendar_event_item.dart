import 'package:audio_cult/app/utils/constants/app_colors.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:audio_cult/w_components/buttons/w_button_inkwell.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../w_components/images/common_image_network.dart';
import '../../../../data_source/models/responses/events/event_response.dart';
import '../../../../utils/route/app_route.dart';

class CalendarEventItem extends StatelessWidget {
  const CalendarEventItem({
    Key? key,
    this.data,
  }) : super(key: key);

  final EventResponse? data;

  @override
  Widget build(BuildContext context) {
    final date = data?.eventDate?.split('-')[0].split(', ')[1].split(' ')[1];
    final month = data?.eventDate?.split('-')[0].split(', ')[1].split(' ')[0];
    final year = data?.eventDate?.split('-')[0].split(', ')[2].split(' ')[0];
    final hour = DateFormat.jm()
        .format(DateFormat('hh:mm').parse(data?.eventDate?.split('-')[0].split(', ')[2].split(' ')[1] ?? ''));

    return WButtonInkwell(
      onPressed: () {
        Navigator.pushNamed(
          context,
          AppRoute.routeEventDetail,
          arguments: {
            'event_id': int.parse(data?.eventId ?? ''),
          },
        );
      },
      child: Row(
        children: [
          CommonImageNetWork(
            width: 56,
            height: 56,
            imagePath: data?.imagePath ?? '',
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 300,
                child: Text(
                  data?.title ?? '',
                  overflow: TextOverflow.ellipsis,
                  style: context.bodyTextStyle()?.copyWith(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                '$hour - $month $date, $year',
                style: context.bodyTextStyle()?.copyWith(
                      color: AppColors.subTitleColor,
                    ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: 300,
                child: Text(
                  data?.location ?? '',
                  overflow: TextOverflow.ellipsis,
                  style: context.bodyTextStyle()?.copyWith(
                        color: AppColors.subTitleColor,
                        fontSize: 12,
                      ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
