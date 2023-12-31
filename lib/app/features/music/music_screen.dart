import 'package:audio_cult/app/features/music/discover/discover_screen.dart';
import 'package:audio_cult/app/features/music/library/library_bloc.dart';
import 'package:audio_cult/app/features/music/library/library_screen.dart';
import 'package:audio_cult/app/features/music/songs/songs_screen.dart';
import 'package:audio_cult/app/injections.dart';
import 'package:audio_cult/app/utils/constants/app_colors.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:audio_cult/w_components/tabbars/common_tabbar.dart';
import 'package:audio_cult/w_components/tabbars/common_tabbar_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_tab_bar/indicator/custom_indicator.dart';
import 'package:provider/provider.dart';

import 'albums/albums_screen.dart';
import 'my_album/my_album_page.dart';

class MusicScreen extends StatefulWidget {
  const MusicScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<MusicScreen> createState() => _MusicScreenState();
}

class _MusicScreenState extends State<MusicScreen> {
  final _pageController = PageController();
  final _tabController = CustomTabBarController();
  final _pageCount = 5;
  var _currentIndex = 0;

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondaryButtonColor,
      body: Provider(
        create: (context) => LibraryBloc(locator.get()),
        child: CommonTabbar(
          pageCount: _pageCount,
          pageController: _pageController,
          tabBarController: _tabController,
          currentIndex: _currentIndex,
          tabbarItemBuilder: (context, index) {
            switch (index) {
              case 0:
                return CommonTabbarItem(
                  index: index,
                  currentIndex: _currentIndex,
                  title: context.localize.t_discover,
                  hasIcon: false,
                );
              case 1:
                return CommonTabbarItem(
                  index: index,
                  currentIndex: _currentIndex,
                  title: context.localize.t_music,
                  hasIcon: false,
                );
              case 2:
                return CommonTabbarItem(
                  index: index,
                  currentIndex: _currentIndex,
                  title: context.localize.t_albums,
                  hasIcon: false,
                );
              case 3:
                return CommonTabbarItem(
                  index: index,
                  currentIndex: _currentIndex,
                  title: context.localize.t_my_library,
                  hasIcon: false,
                );
              case 4:
                return CommonTabbarItem(
                  index: index,
                  currentIndex: _currentIndex,
                  title: context.localize.t_my_album,
                  hasIcon: false,
                );
              default:
                return const SizedBox();
            }
          },
          pageViewBuilder: (context, index) {
            switch (index) {
              case 0:
                return const DiscoverScreen();
              case 1:
                return const SongsScreen();
              case 2:
                return const AlbumsScreen();
              case 3:
                return const LibraryScreen();
              case 4:
                return const MyAlbumPage();
              default:
                return const SizedBox();
            }
          },
          onTapItem: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          onPageChanged: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
        ),
      ),
    );
  }
}
