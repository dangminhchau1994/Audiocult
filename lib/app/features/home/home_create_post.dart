import 'package:audio_cult/app/features/home/post_photos/post_photos.dart';
import 'package:audio_cult/app/features/home/post_status/post_status.dart';
import 'package:audio_cult/app/features/home/post_video/post_video.dart';
import 'package:audio_cult/app/utils/constants/app_assets.dart';
import 'package:audio_cult/app/utils/constants/app_colors.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:audio_cult/w_components/appbar/common_appbar.dart';
import 'package:audio_cult/w_components/buttons/w_button_inkwell.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_tab_bar/indicator/custom_indicator.dart';
import 'package:flutter_svg/svg.dart';

import '../../../w_components/tabbars/common_tabbar.dart';
import '../../../w_components/tabbars/common_tabbar_item.dart';

class HomeCreatePost extends StatefulWidget {
  const HomeCreatePost({
    Key? key,
    this.userId,
    this.eventId,
    this.eventFeedId,
  }) : super(key: key);

  final String? userId;
  final int? eventId;
  final int? eventFeedId;

  @override
  State<HomeCreatePost> createState() => _HomeCreatePostState();
}

class _HomeCreatePostState extends State<HomeCreatePost> {
  final _pageController = PageController();
  final _tabController = CustomTabBarController();
  var _pageCount = 0;
  var _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageCount = widget.eventId != null ? 2 : 3;
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        backgroundColor: AppColors.mainColor,
        appBar: CommonAppBar(
          backgroundColor: AppColors.secondaryButtonColor,
          leadingWidth: 120,
          leading: Center(
            child: Text(
              context.localize.t_create_post,
              style: context.bodyTextPrimaryStyle()!.copyWith(color: Colors.white, fontSize: 18),
            ),
          ),
          actions: [
            WButtonInkwell(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Padding(
                padding: EdgeInsets.all(14),
                child: Icon(
                  Icons.close,
                  color: Colors.white,
                ),
              ),
            )
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
                  width: MediaQuery.of(context).size.width / _pageCount,
                  currentIndex: _currentIndex,
                  title: context.localize.t_status,
                  unActiveIcon: SvgPicture.asset(AppAssets.edit, width: 20, height: 20),
                  activeIcon: SvgPicture.asset(AppAssets.activeEdit, width: 20, height: 20),
                  hasIcon: true,
                );
              case 1:
                return CommonTabbarItem(
                  index: index,
                  width: MediaQuery.of(context).size.width / _pageCount,
                  currentIndex: _currentIndex,
                  unActiveIcon: SvgPicture.asset(AppAssets.photo, width: 20, height: 20),
                  activeIcon: SvgPicture.asset(AppAssets.activePhoto, width: 20, height: 20),
                  title: context.localize.t_photos,
                  hasIcon: true,
                );
              case 2:
                return widget.eventId != null
                    ? const SizedBox()
                    : CommonTabbarItem(
                        index: index,
                        width: MediaQuery.of(context).size.width / _pageCount,
                        currentIndex: _currentIndex,
                        unActiveIcon: SvgPicture.asset(AppAssets.video, width: 20, height: 20),
                        activeIcon: SvgPicture.asset(AppAssets.activeVideo, width: 20, height: 20),
                        title: context.localize.t_videos,
                        hasIcon: true,
                      );
              default:
                return const SizedBox();
            }
          },
          pageViewBuilder: (context, index) {
            switch (index) {
              case 0:
                return PostStatus(
                  eventId: widget.eventId,
                  userId: widget.userId,
                );
              case 1:
                return PostPhotos(
                  userId: widget.userId,
                );
              case 2:
                return widget.eventId != null
                    ? const SizedBox()
                    : PostVideo(
                        userId: widget.userId,
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
      ),
    );
  }
}
