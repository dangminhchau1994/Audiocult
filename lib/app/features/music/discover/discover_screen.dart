import 'package:audio_cult/app/data_source/models/responses/fake_song.dart';
import 'package:audio_cult/app/features/music/discover/discover_bloc.dart';
import 'package:audio_cult/app/features/music/discover/widgets/featured_albums.dart';
import 'package:audio_cult/app/features/music/discover/widgets/featured_mixtapes.dart';
import 'package:audio_cult/app/features/music/discover/widgets/song_of_day.dart';
import 'package:audio_cult/app/features/music/discover/widgets/top_playlist.dart';
import 'package:audio_cult/app/features/music/discover/widgets/top_songs.dart';
import 'package:audio_cult/app/injections.dart';
import 'package:audio_cult/app/utils/constants/app_colors.dart';
import 'package:audio_cult/app/utils/constants/app_dimens.dart';
import 'package:flutter/material.dart';

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({Key? key}) : super(key: key);

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  final albums = FakeSong.generateAlbums();

  @override
  void initState() {
    locator.get<DiscoverBloc>().getTopSongs('most-viewed', 1, 3);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.symmetric(
            horizontal: kHorizontalSpacing,
            vertical: kVerticalSpacing,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SongOfDay(),
                TopSongs(
                  onPageChange: (index) {
                    locator.get<DiscoverBloc>().getTopSongs('most-viewed', index + 1, 3);
                  },
                ),
                FeaturedAlbums(
                  albums: albums,
                ),
                FeatureMixtapes(
                  onPageChange: (index) {},
                ),
                TopPlaylist(
                  topPlaylists: albums,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
