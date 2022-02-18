import 'package:audio_cult/app/features/music/discover/discover_screen.dart';
import 'package:audio_cult/app/utils/constants/app_colors.dart';
import 'package:audio_cult/w_components/tabbars/common_tabbar.dart';
import 'package:audio_cult/w_components/tabbars/common_tabbar_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_tab_bar/indicator/custom_indicator.dart';

class MusicScreen extends StatefulWidget {
  const MusicScreen({Key? key}) : super(key: key);

  @override
  State<MusicScreen> createState() => _MusicScreenState();
}

class _MusicScreenState extends State<MusicScreen> {
  final _pageController = PageController();
  final _tabController = CustomTabBarController();
  final _pageCount = 2;
  var _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondaryButtonColor,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Music',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: AppColors.secondaryButtonColor,
        elevation: 0,
        bottomOpacity: 0,
      ),
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
                width: MediaQuery.of(context).size.width / 2,
                currentIndex: _currentIndex,
                title: 'Discover',
                hasIcon: false,
              );
            case 1:
              return CommonTabbarItem(
                index: index,
                width: MediaQuery.of(context).size.width / 2,
                currentIndex: _currentIndex,
                title: 'My Library',
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
              return const SizedBox(
                child: Center(
                  child: Text('My Library'),
                ),
              );
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
