import 'package:audio_cult/app/data_source/models/responses/album/album_response.dart';
import 'package:audio_cult/app/features/music/detail_album/detail_album_bloc.dart';
import 'package:audio_cult/app/features/music/detail_album/widgets/detail_album_navbar.dart';
import 'package:audio_cult/app/features/music/detail_album/widgets/detail_album_photo.dart';
import 'package:audio_cult/app/features/music/detail_album/widgets/detail_album_play_button.dart';
import 'package:audio_cult/app/features/music/detail_album/widgets/detail_album_title.dart';
import 'package:flutter/material.dart';

import '../../../../../w_components/appbar/common_appbar.dart';

class CustomSliverAlbum extends SliverPersistentHeaderDelegate {
  final double? expandedHeight;
  final Album? detail;
  final DetailAlbumBloc? albumBloc;

  const CustomSliverAlbum({
    this.expandedHeight,
    this.detail,
    this.albumBloc,
  });

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    const size = 60;
    final top = expandedHeight! - shrinkOffset - size / 2;

    return Stack(
      children: [
        //Photo
        DetailAlbumPhoto(
          imagePath: detail?.imagePath,
        ),
        //Navbar
        const DetailAlbumNavBar(),
        //Title
        DetailAlbumTitle(
          time: detail?.timeStamp,
          userName: detail?.fullName ?? '',
          title: detail?.name,
        ),
        // Play Button
        DetailAlbumPlayButton(
          albumBloc: albumBloc,
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
        title: detail?.name ?? '',
      ));

  @override
  double get maxExtent => expandedHeight!;

  @override
  double get minExtent => kToolbarHeight + 30;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
