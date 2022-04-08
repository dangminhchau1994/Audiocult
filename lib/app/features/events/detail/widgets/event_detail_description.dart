import 'package:audio_cult/app/data_source/models/responses/events/event_response.dart';
import 'package:audio_cult/app/utils/constants/app_dimens.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:audio_cult/l10n/l10n.dart';
import 'package:flutter/material.dart';

import '../../../../utils/constants/app_colors.dart';

class EventDetailDescription extends StatelessWidget {
  const EventDetailDescription({
    Key? key,
    this.data,
  }) : super(key: key);

  final EventResponse? data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: kHorizontalSpacing,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.l10n.t_description,
            style: context.bodyTextPrimaryStyle()!.copyWith(
                  color: AppColors.subTitleColor,
                  fontSize: 16,
                ),
          ),
          const SizedBox(height: 10),
          if (data!.tags!.isNotEmpty)
            Wrap(
              spacing: 8,
              runSpacing: 4,
              children: data!.tags!
                  .split(',')
                  .map(
                    (e) => Text(
                      '#$e',
                      style: context.bodyTextPrimaryStyle()!.copyWith(
                            color: AppColors.lightBlue,
                            fontSize: 14,
                          ),
                    ),
                  )
                  .toList(),
            )
          else
            const SizedBox(),
          const SizedBox(height: 10),
          SizedBox(
            width: 500,
            child: Text(
              data?.description ?? '',
              overflow: TextOverflow.ellipsis,
              maxLines: 5,
              style: context.bodyTextPrimaryStyle()!.copyWith(
                    color: Colors.white,
                    fontSize: 14,
                  ),
            ),
          )
        ],
      ),
    );
  }
}
