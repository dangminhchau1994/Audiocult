import 'package:audio_cult/app/features/music/discover/discover_screen.dart';
import 'package:audio_cult/app/features/music/library/library_screen.dart';
import 'package:audio_cult/app/features/music/songs/songs_screen.dart';
import 'package:audio_cult/app/utils/constants/app_colors.dart';
import 'package:audio_cult/w_components/tabbars/common_tabbar.dart';
import 'package:audio_cult/w_components/tabbars/common_tabbar_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_tab_bar/indicator/custom_indicator.dart';

import 'albums/albums_screen.dart';
import 'my_album/my_album_page.dart';

class MusicScreen extends StatefulWidget {
  const MusicScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<MusicScreen> createState() => _MusicScreenState();
}

class _MusicScreenState extends State<MusicScreen>  {
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
      body: CommonTabbar(
        pageCount: _pageCount,
        pageController: _pageController,
        tabBarController: _tabController,
        currentIndex: _currentIndex,
        tabbarItemBuilder: (context, index) {
          switch (index) {
            case 0:
              return CommonTabbarItem(
                index: index,
                width: MediaQuery.of(context).size.width / 4,
                currentIndex: _currentIndex,
                title: 'Discover',
                hasIcon: false,
              );
            case 1:
              return CommonTabbarItem(
                index: index,
                width: MediaQuery.of(context).size.width / 4,
                currentIndex: _currentIndex,
                title: 'Musics',
                hasIcon: false,
              );
            case 2:
              return CommonTabbarItem(
                index: index,
                width: MediaQuery.of(context).size.width / 4,
                currentIndex: _currentIndex,
                title: 'Albums',
                hasIcon: false,
              );
            case 3:
              return CommonTabbarItem(
                index: index,
                width: MediaQuery.of(context).size.width / 4,
                currentIndex: _currentIndex,
                title: 'My Library',
                hasIcon: false,
              );
            case 4:
              return CommonTabbarItem(
                index: index,
                width: MediaQuery.of(context).size.width / 4,
                currentIndex: _currentIndex,
                title: 'My Album',
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
    );
  }
}
