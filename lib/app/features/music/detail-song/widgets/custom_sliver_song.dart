import 'package:audio_cult/app/data_source/models/responses/song/song_response.dart';
import 'package:audio_cult/app/features/music/detail-song/widgets/detail_song_navbar.dart';
import 'package:audio_cult/app/features/music/detail-song/widgets/detail_song_photo.dart';
import 'package:audio_cult/app/features/music/detail-song/widgets/detail_song_play_button.dart';
import 'package:audio_cult/app/features/music/detail-song/widgets/detail_song_title.dart';
import 'package:audio_cult/w_components/appbar/common_appbar.dart';
import 'package:flutter/material.dart';

class CustomSliverSong extends SliverPersistentHeaderDelegate {
  final double? expandedHeight;
  final Song? detail;

  CustomSliverSong({
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
        DetailPhotoSong(
          imagePath: detail?.imagePath,
        ),
        //Navbar
        const DetailSongNavBar(),
        //Title
        DetailSongTitle(
          time: detail?.timeStamp,
          artistName: detail?.artistUser?.userName,
          title: detail?.title,
        ),
        // Play Button
        DetailSongPlayButton(
          song: detail,
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
        title: detail?.title ?? '',
      ));

  @override
  double get maxExtent => expandedHeight!;

  @override
  double get minExtent => kToolbarHeight + 30;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
