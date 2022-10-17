import 'package:audio_cult/app/data_source/models/responses/events/event_response.dart';
import 'package:audio_cult/app/utils/constants/app_dimens.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:audio_cult/w_components/buttons/w_button_inkwell.dart';
import 'package:flutter/material.dart';

import '../../../../data_source/models/requests/event_request.dart';
import '../../../../utils/constants/app_colors.dart';
import '../../../../utils/route/app_route.dart';

class EventDetailDescription extends StatelessWidget {
  const EventDetailDescription({
    Key? key,
    this.data,
  }) : super(key: key);

  final EventResponse? data;

  @override
  Widget build(BuildContext context) {
    final isTagEmpty = data?.tags?.isNotEmpty ?? false;

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: kHorizontalSpacing,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Visibility(
            visible: isTagEmpty,
            child: Text(
              context.localize.t_description,
              style: context.bodyTextPrimaryStyle()!.copyWith(
                    color: AppColors.subTitleColor,
                    fontSize: 16,
                  ),
            ),
          ),
          const SizedBox(height: 10),
          if (isTagEmpty)
            Wrap(
              spacing: 8,
              runSpacing: 4,
              children: data!.tags!
                  .split(',')
                  .map(
                    (e) => WButtonInkwell(
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          AppRoute.routeResultEvent,
                          arguments: {'event_result': EventRequest(tag: e.replaceAll('#', ''))},
                        );
                      },
                      child: Text(
                        '#$e',
                        style: context.bodyTextPrimaryStyle()!.copyWith(
                              color: AppColors.lightBlue,
                              fontSize: 16,
                            ),
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
