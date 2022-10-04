import 'package:audio_cult/app/utils/constants/app_colors.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:audio_cult/app/utils/route/app_route.dart';
import 'package:audio_cult/w_components/buttons/w_button_inkwell.dart';
import 'package:audio_cult/w_components/images/common_image_network.dart';
import 'package:audio_cult/w_components/tag_label/tag_label.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../data_source/models/responses/events/event_response.dart';

class PopularEventItem extends StatelessWidget {
  const PopularEventItem({
    Key? key,
    this.data,
    this.isMyEvent = false,
  }) : super(key: key);

  final EventResponse? data;
  final bool isMyEvent;

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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              CommonImageNetWork(
                width: 250,
                height: 176,
                imagePath: data?.imagePath ?? '',
              ),
              if (isMyEvent)
                const TagLabel()
              else
                Container(),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            data?.title ?? '',
            style: context.bodyTextStyle()?.copyWith(
                  color: Colors.white,
                  fontSize: 16,
                ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            '$hour - $month $date, $year',
            style: context.bodyTextPrimaryStyle()!.copyWith(
                  color: AppColors.subTitleColor,
                ),
          ),
          const SizedBox(height: 6),
          SizedBox(
            width: 300,
            child: Text(
              data?.location ?? '',
              overflow: TextOverflow.ellipsis,
              style: context.bodyTextStyle()?.copyWith(
                    color: AppColors.subTitleColor,
                    fontSize: 16,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
