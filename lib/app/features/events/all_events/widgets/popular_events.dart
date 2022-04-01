import 'package:audio_cult/app/features/events/all_events/widgets/popular_event_item.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:audio_cult/l10n/l10n.dart';
import 'package:flutter/material.dart';

class PopularEvents extends StatefulWidget {
  const PopularEvents({Key? key}) : super(key: key);

  @override
  State<PopularEvents> createState() => _PopularEventsState();
}

class _PopularEventsState extends State<PopularEvents> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.l10n.t_popular_events,
          style: context.bodyTextStyle()?.copyWith(
                color: Colors.white,
                fontSize: 14,
              ),
        ),
        const SizedBox(
          height: 20,
        ),
        SizedBox(
          height: 240,
          child: ListView.separated(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            separatorBuilder: (context, index) => const SizedBox(
              width: 20,
            ),
            itemCount: 3,
            itemBuilder: (context, index) {
              return const PopularEventItem();
            },
          ),
        ),
      ],
    );
  }
}
