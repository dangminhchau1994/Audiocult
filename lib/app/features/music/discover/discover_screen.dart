import 'package:audio_cult/app/data_source/models/requests/top_song_request.dart';
import 'package:audio_cult/app/features/music/discover/discover_bloc.dart';
import 'package:audio_cult/app/features/music/discover/widgets/featured_albums.dart';
import 'package:audio_cult/app/features/music/discover/widgets/featured_mixtapes.dart';
import 'package:audio_cult/app/features/music/discover/widgets/song_of_day.dart';
import 'package:audio_cult/app/features/music/discover/widgets/top_playlist.dart';
import 'package:audio_cult/app/features/music/discover/widgets/top_songs.dart';
import 'package:audio_cult/app/utils/constants/app_colors.dart';
import 'package:audio_cult/app/utils/constants/app_dimens.dart';
import 'package:audio_cult/app/utils/route/app_route.dart';
import 'package:flutter/material.dart';
import '../../../../di/bloc_locator.dart';
import '../search/search_args.dart';
import '../search/search_screen.dart';

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({Key? key}) : super(key: key);

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> with AutomaticKeepAliveClientMixin {
  final _topSongPageController = PageController();
  final _featuredMixTapPageController = PageController();
  var _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _getAllData();
  }

  @override
  void dispose() {
    super.dispose();
    _topSongPageController.dispose();
    _featuredMixTapPageController.dispose();
  }

  void _getAllData() {
    getIt.get<DiscoverBloc>().getTopSongs(TopSongRequest(sort: 'most-viewed', page: 1, limit: 3));
    getIt.get<DiscoverBloc>().getAlbums('', 'featured', '', '', '', 1, 3);
    getIt.get<DiscoverBloc>().getMixTapSongs('', 'most-viewed', '', '', 1, 3, 'featured', 'mixtape-song');
    getIt.get<DiscoverBloc>().getPlaylist('', 1, 2, 'most-liked', '', '', 1);
    getIt.get<DiscoverBloc>().getSongOfDay();
  }

  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      body: SafeArea(
        child: RefreshIndicator(
          color: AppColors.primaryButtonColor,
          backgroundColor: AppColors.secondaryButtonColor,
          onRefresh: () async {
            _getAllData();
            _topSongPageController.jumpTo(0);
            _featuredMixTapPageController.jumpTo(0);
          },
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: kHorizontalSpacing,
                vertical: kVerticalSpacing,
              ),
              child: Column(
                children: [
                  const SongOfDay(),
                  TopSongs(
                    itemCount: 3,
                    pageController: _topSongPageController,
                    onShowAll: () {
                      Navigator.pushNamed(
                        context,
                        AppRoute.routeTopSongs,
                        arguments: SearchArgs(
                          searchType: SearchType.topSong,
                        ),
                      );
                    },
                    isTopSong: true,
                    onNextPage: (index) {
                      _topSongPageController.animateToPage(
                        ++index > 2 ? 0 : index,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.ease,
                      );
                      getIt
                          .get<DiscoverBloc>()
                          .getTopSongs(TopSongRequest(sort: 'most-viewed', page: index++ > 2 ? 1 : index++, limit: 3));
                    },
                    onPageChange: (index) {
                      getIt
                          .get<DiscoverBloc>()
                          .getTopSongs(TopSongRequest(sort: 'most-viewed', page: index + 1, limit: 3));
                      _currentIndex = index;
                      setState(() {});
                    },
                    onRetry: () {
                      getIt
                          .get<DiscoverBloc>()
                          .getTopSongs(TopSongRequest(sort: 'most-viewed', page: _currentIndex + 1, limit: 3));
                    },
                  ),
                  FeaturedAlbums(
                    onRetry: () {
                      getIt.get<DiscoverBloc>().getAlbums('', 'featured', '', '', '', 1, 3);
                    },
                    onShowAll: () {
                      Navigator.pushNamed(
                        context,
                        AppRoute.routeFeaturedAlbum,
                        arguments: SearchArgs(
                          searchType: SearchType.album,
                        ),
                      );
                    },
                  ),
                  FeatureMixtapes(
                    itemCount: 2,
                    pageController: _featuredMixTapPageController,
                    isTopSong: false,
                    onNextPage: (index) {
                      _featuredMixTapPageController.animateToPage(
                        ++index > 1 ? 0 : index,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.ease,
                      );
                      getIt
                          .get<DiscoverBloc>()
                          .getTopSongs(TopSongRequest(sort: 'most-viewed', page: index++ > 1 ? 1 : index++, limit: 3));
                    },
                    onPageChange: (index) {
                      getIt
                          .get<DiscoverBloc>()
                          .getMixTapSongs('', 'most-viewed', '', '', index + 1, 3, 'featured', 'mixtape-song');
                      setState(() {
                        _currentIndex = index;
                      });
                    },
                    onRetry: () {
                      getIt
                          .get<DiscoverBloc>()
                          .getMixTapSongs('', 'most-viewed', '', '', _currentIndex + 1, 3, 'featured', 'mixtape-song');
                    },
                    onShowAll: () {
                      Navigator.pushNamed(
                        context,
                        AppRoute.routeMixTapeSongs,
                        arguments: SearchArgs(
                          searchType: SearchType.mixtapes,
                        ),
                      );
                    },
                  ),
                  TopPlaylist(
                    onShowAll: () {
                      Navigator.pushNamed(
                        context,
                        AppRoute.routeTopPlaylist,
                        arguments: SearchArgs(
                          searchType: SearchType.playlist,
                        ),
                      );
                    },
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
