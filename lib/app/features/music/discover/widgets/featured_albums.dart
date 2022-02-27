import 'package:audio_cult/app/base/bloc_state.dart';
import 'package:audio_cult/app/data_source/models/responses/fake_song.dart';
import 'package:audio_cult/app/features/music/discover/discover_bloc.dart';
import 'package:audio_cult/app/features/music/discover/widgets/album_item.dart';
import 'package:audio_cult/app/features/music/discover/widgets/section_title.dart';
import 'package:audio_cult/app/injections.dart';
import 'package:flutter/material.dart';

class FeaturedAlbums extends StatelessWidget {
  const FeaturedAlbums({
    Key? key,
    this.albums,
  }) : super(key: key);

  final List<FakeSong>? albums;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionTitle(
            title: 'Featured Albums',
          ),
          const SizedBox(
            height: 16,
          ),
          SizedBox(
            height: 278,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => AlbumItem(album: albums?[index]),
              separatorBuilder: (context, index) => const SizedBox(width: 16),
              itemCount: albums?.length ?? 0,
            ),
          ),
        ],
      ),
    );
  }
}
