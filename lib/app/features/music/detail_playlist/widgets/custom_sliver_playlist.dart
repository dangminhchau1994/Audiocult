import 'package:audio_cult/app/data_source/models/responses/playlist/playlist_response.dart';
import 'package:audio_cult/app/features/music/detail_playlist/widgets/detail_playlist_navbar.dart';
import 'package:audio_cult/app/features/music/detail_playlist/widgets/detail_playlist_photo.dart';
import 'package:audio_cult/app/features/music/detail_playlist/widgets/detail_playlist_play_button.dart';
import 'package:audio_cult/app/features/music/detail_playlist/widgets/detail_playlist_title.dart';
import 'package:flutter/material.dart';

import '../../../../../w_components/appbar/common_appbar.dart';

class CustomSliverPlayList extends SliverPersistentHeaderDelegate {
  final double? expandedHeight;
  final PlaylistResponse? detail;

  CustomSliverPlayList({
    this.expandedHeight,
    this.detail,
  });

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    const size = 60;
    final top = expandedHeight! - shrinkOffset - size / 2;

    return Stack(
      children: [
        //Photo
        DetailPlayListPhoto(
          imagePath: detail?.imagePath,
        ),
        //Navbar
        const DetailPlayListNavBar(),
        //Title
        DetailPlayListTitle(
          time: detail?.timeStamp,
          userName: detail?.fullName,
          title: detail?.title,
        ),
        // Play Button
        const DetailPlayListPlayButton(),
        buildAppBar(shrinkOffset),
      ],
    );
  }

  double appear(double shrinkOffset) => shrinkOffset / expandedHeight!;

  double disappear(double shrinkOffset) => 1 - shrinkOffset / expandedHeight!;

  Widget buildAppBar(double shrinkOffset) => Opacity(
      opacity: appear(shrinkOffset),
      child: CommonAppBar(
        title: detail?.title ?? '',
      ));

  @override
  double get maxExtent => expandedHeight!;

  @override
  double get minExtent => kToolbarHeight + 30;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
