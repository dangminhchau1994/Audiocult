import 'package:audio_cult/app/features/events/my_diary/my_diary_screen.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';

import 'package:flutter/material.dart';
import 'package:flutter_custom_tab_bar/indicator/custom_indicator.dart';

import '../../../w_components/tabbars/common_tabbar.dart';
import '../../../w_components/tabbars/common_tabbar_item.dart';
import '../../utils/constants/app_colors.dart';
import 'all_events/all_events_screen.dart';

class EventScreen extends StatefulWidget {
  const EventScreen({Key? key}) : super(key: key);

  @override
  State<EventScreen> createState() => EventScreenState();
}

class EventScreenState extends State<EventScreen> {
  final _pageController = PageController();
  final _tabController = CustomTabBarController();
  final _pageCount = 4;
  var _currentIndex = 0;

  void startWithTicket() {
    setState(() {
      _currentIndex = 2;
      _pageController.jumpToPage(2);
    });
  }

  @override
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
                currentIndex: _currentIndex,
                title: context.localize.t_all_events,
                hasIcon: false,
              );
            case 1:
              return CommonTabbarItem(
                index: index,
                currentIndex: _currentIndex,
                title: context.localize.t_my_diary,
                hasIcon: false,
              );
            case 2:
              return CommonTabbarItem(
                index: index,
                currentIndex: _currentIndex,
                title: context.localize.t_my_tickets,
                hasIcon: false,
              );
            case 3:
              return CommonTabbarItem(
                index: index,
                currentIndex: _currentIndex,
                title: context.localize.t_invitations,
                hasIcon: false,
              );
            default:
              return const SizedBox();
          }
        },
        pageViewBuilder: (context, index) {
          switch (index) {
            case 0:
              return const AllEventsScreen();
            case 1:
              return const MyDiaryScreen();
            case 2:
              return const SizedBox();
            case 3:
              return const SizedBox();
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
