import 'package:audio_cult/app/data_source/models/responses/profile_data.dart';
import 'package:audio_cult/app/features/main/main_bloc.dart';
import 'package:audio_cult/app/features/music/discover/discover_screen.dart';
import 'package:audio_cult/app/features/music/library/library_screen.dart';
import 'package:audio_cult/app/injections.dart';
import 'package:audio_cult/app/utils/constants/app_assets.dart';
import 'package:audio_cult/app/utils/constants/app_colors.dart';
import 'package:audio_cult/w_components/appbar/common_appbar.dart';
import 'package:audio_cult/w_components/menus/common_fab_menu.dart';
import 'package:audio_cult/w_components/tabbars/common_tabbar.dart';
import 'package:audio_cult/w_components/tabbars/common_tabbar_item.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_tab_bar/indicator/custom_indicator.dart';
import 'package:flutter_svg/svg.dart';

import '../../../w_components/images/no_image_available.dart';

class MusicScreen extends StatefulWidget {
  final Function()? onPressAvatar;
  const MusicScreen({Key? key, this.onPressAvatar}) : super(key: key);

  @override
  State<MusicScreen> createState() => _MusicScreenState();
}

class _MusicScreenState extends State<MusicScreen> with AutomaticKeepAliveClientMixin {
  final _pageController = PageController();
  final _tabController = CustomTabBarController();
  final _pageCount = 2;
  var _currentIndex = 0;
  final MainBloc _mainBloc = locator.get();
  ProfileData? _profileData;
  @override
  void initState() {
    super.initState();
    _mainBloc.profileStream.listen((event) {
      setState(() {
        _profileData = event;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondaryButtonColor,
      appBar: CommonAppBar(
        title: 'Music',
        leading: GestureDetector(
          onTap: () {
            widget.onPressAvatar?.call();
          },
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            child: ClipOval(
              child: CachedNetworkImage(
                width: 36,
                height: 36,
                fit: BoxFit.cover,
                errorWidget: (context, url, error) => const NoImageAvailable(),
                imageUrl: _profileData != null ? _profileData!.userImage ?? '' : '',
              ),
            ),
          ),
        ),
        actions: [
          Container(
            padding: const EdgeInsets.all(8),
            margin: const EdgeInsets.symmetric(horizontal: 8),
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: AppColors.inputFillColor,
              shape: BoxShape.circle,
            ),
            child: SvgPicture.asset(
              AppAssets.searchIcon,
              fit: BoxFit.cover,
            ),
          ),
          CommonFabMenu(
            onSearchTap: () {},
            onNotificationTap: () {},
            onCartTap: () {},
          ),
        ],
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
              return const LibraryScreen();
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

  @override
  bool get wantKeepAlive => true;
}
