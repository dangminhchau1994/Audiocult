import 'package:audio_cult/app/data_source/models/responses/events/event_response.dart';
import 'package:audio_cult/app/features/events/detail/widgets/event_detail_festival.dart';
import 'package:audio_cult/app/features/events/detail/widgets/event_detail_navbar.dart';
import 'package:audio_cult/app/features/events/detail/widgets/event_detail_title.dart';
import 'package:flutter/material.dart';

import '../../../../../w_components/appbar/common_appbar.dart';
import 'event_detail_photo.dart';

class CustomEventSliver extends SliverPersistentHeaderDelegate {
  final double? expandedHeight;
  final EventResponse? data;

  CustomEventSliver({
    this.expandedHeight,
    this.data,
  });

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      children: [
        EventDetailPhoto(imagePath: data?.imagePath ?? ''),
        const EventDetailNavBar(),
        EventDetailTitle(title: data?.title ?? ''),
        EventDetailFestiVal(
          category: data?.categories?[0][0],
        ),
        buildAppBar(shrinkOffset),
      ],
    );
  }

  double appear(double shrinkOffset) => shrinkOffset / expandedHeight!;

  double disappear(double shrinkOffset) => 1 - shrinkOffset / expandedHeight!;

  Widget buildAppBar(double shrinkOffset) => Opacity(
      opacity: appear(shrinkOffset),
      child: CommonAppBar(
        title: data?.title ?? '',
      ));

  @override
  double get maxExtent => expandedHeight!;

  @override
  double get minExtent => kToolbarHeight + 30;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
