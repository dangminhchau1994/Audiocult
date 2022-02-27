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

class _DiscoverScreenState extends State<DiscoverScreen> with AutomaticKeepAliveClientMixin {
  final albums = FakeSong.generateAlbums();
  var _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _getAllData();
  }

  void _getAllData() {
    locator.get<DiscoverBloc>().getTopSongs('most-viewed', 1, 3);
    locator.get<DiscoverBloc>().getAlbums('featured', 1, 3);
    locator.get<DiscoverBloc>().getMixTapSongs('most-viewed', 1, 3, 'featured', 'mixtape-song');
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
          child: RefreshIndicator(
            color: Colors.white,
            backgroundColor: AppColors.primaryButtonColor,
            onRefresh: () async {
              _getAllData();
            },
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SongOfDay(),
                  TopSongs(
                    isTopSong: true,
                    onPageChange: (index) {
                      locator.get<DiscoverBloc>().getTopSongs('most-viewed', index + 1, 3);
                      setState(() {
                        _currentIndex = index;
                      });
                    },
                    onRetry: () {
                      locator.get<DiscoverBloc>().getTopSongs('most-viewed', _currentIndex + 1, 3);
                    },
                  ),
                  const FeaturedAlbums(),
                  FeatureMixtapes(
                    isTopSong: false,
                    onPageChange: (index) {
                      locator
                          .get<DiscoverBloc>()
                          .getMixTapSongs('most-viewed', index + 1, 3, 'featured', 'mixtape-song');
                      setState(() {
                        _currentIndex = index;
                      });
                    },
                    onRetry: () {
                      locator
                          .get<DiscoverBloc>()
                          .getMixTapSongs('most-viewed', _currentIndex + 1, 3, 'featured', 'mixtape-song');
                    },
                  ),
                  TopPlaylist(
                    topPlaylists: albums,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
