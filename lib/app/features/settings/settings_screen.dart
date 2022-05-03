// import 'package:audio_cult/app/features/settings/page_template/page_template_screen.dart';
// import 'package:audio_cult/app/utils/constants/app_assets.dart';
// import 'package:audio_cult/app/utils/constants/app_colors.dart';
// import 'package:audio_cult/l10n/l10n.dart';
// import 'package:audio_cult/w_components/appbar/common_appbar.dart';
// import 'package:audio_cult/w_components/menus/common_fab_menu.dart';
// import 'package:audio_cult/w_components/tabbars/common_tabbar.dart';
// import 'package:audio_cult/w_components/tabbars/common_tabbar_item.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_custom_tab_bar/indicator/custom_indicator.dart';
// import 'package:flutter_svg/flutter_svg.dart';

// class SettingsScreen extends StatefulWidget {
//   const SettingsScreen({Key? key}) : super(key: key);

//   @override
//   State<SettingsScreen> createState() => _SettingsScreenState();
// }

// class _SettingsScreenState extends State<SettingsScreen> with SingleTickerProviderStateMixin {
//   var _currentPageIndex = 0;
//   final _tabbarItems = <CommonTabbarItem>[];

//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     // _initTabbarItems();
//   }

//   void _initTabbarItems() {
//     _tabbarItems.addAll([
//       CommonTabbarItem(
//         index: 0,
//         width: MediaQuery.of(context).size.width / 4,
//         currentIndex: _currentPageIndex,
//         title: context.l10n.t_my_tickets,
//         hasIcon: false,
//       ),
//       CommonTabbarItem(
//         index: 1,
//         width: MediaQuery.of(context).size.width / 4,
//         currentIndex: _currentPageIndex,
//         title: context.l10n.t_account,
//         hasIcon: false,
//       ),
//       CommonTabbarItem(
//         index: 2,
//         width: MediaQuery.of(context).size.width / 4,
//         currentIndex: _currentPageIndex,
//         title: context.l10n.t_privacy,
//         hasIcon: false,
//       ),
//       CommonTabbarItem(
//         index: 3,
//         width: MediaQuery.of(context).size.width / 4,
//         currentIndex: _currentPageIndex,
//         title: context.l10n.t_notification,
//         hasIcon: false,
//       ),
//     ]);
//   }

//   Widget _buildIcon(int currentIndex) {
//     if (currentIndex == 0 || currentIndex == 1) {
//       return SvgPicture.asset(
//         AppAssets.messageIcon,
//         fit: BoxFit.cover,
//       );
//     } else {
//       return SvgPicture.asset(
//         AppAssets.searchIcon,
//         fit: BoxFit.cover,
//       );
//     }
//   }

//   final _pageController = PageController();

//   final _tabController = CustomTabBarController();
//   final _pageCount = 4;
//   var _currentIndex = 0;
//   @override
//   Widget build(BuildContext context) {
//     // return Scaffold(
//     //   backgroundColor: Colors.red,
//     //   body: Text('123123213213'),
//     // );
//     return Scaffold(
//       backgroundColor: AppColors.pealSky,
//       body: CommonTabbar(
//         pageCount: _pageCount,
//         pageController: _pageController,
//         tabBarController: _tabController,
//         currentIndex: 0,
//         tabbarItemBuilder: (context, index) {
//           switch (index) {
//             case 0:
//               return CommonTabbarItem(
//                 index: index,
//                 width: MediaQuery.of(context).size.width / _pageCount,
//                 currentIndex: _currentIndex,
//                 title: context.l10n.t_all_events,
import 'package:audio_cult/app/features/atlas/atlas_screen.dart';
import 'package:audio_cult/app/features/events/all_events/all_events_screen.dart';
import 'package:audio_cult/app/features/events/my_diary/my_diary_screen.dart';
import 'package:audio_cult/app/features/settings/page_template/page_template_screen.dart';
import 'package:audio_cult/app/utils/constants/app_assets.dart';
import 'package:audio_cult/l10n/l10n.dart';
import 'package:audio_cult/w_components/appbar/common_appbar.dart';
import 'package:audio_cult/w_components/menus/common_fab_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_tab_bar/indicator/custom_indicator.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../w_components/tabbars/common_tabbar.dart';
import '../../../w_components/tabbars/common_tabbar_item.dart';
import '../../utils/constants/app_colors.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final _pageController = PageController();
  final _tabController = CustomTabBarController();
  final _pageCount = 4;
  var _currentIndex = 0;
  final _tabbarItems = <CommonTabbarItem>[];
  var _currentPageIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _initTabbarItems();
  }

  void _initTabbarItems() {
    _tabbarItems.addAll([
      CommonTabbarItem(
        index: 0,
        // width: MediaQuery.of(context).size.width / 2,
        currentIndex: _currentPageIndex,
        title: 'Page template',
        hasIcon: false,
      ),
      CommonTabbarItem(
        index: 1,
        // width: MediaQuery.of(context).size.width / 4,
        currentIndex: _currentPageIndex,
        title: 'Account',
        hasIcon: false,
      ),
      CommonTabbarItem(
        index: 2,
        // width: MediaQuery.of(context).size.width / 4,
        currentIndex: _currentPageIndex,
        title: 'Privacy',
        hasIcon: false,
      ),
      CommonTabbarItem(
        index: 3,
        // width: MediaQuery.of(context).size.width / 4,
        currentIndex: _currentPageIndex,
        title: 'Notification',
        hasIcon: false,
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
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
              AppAssets.messageIcon,
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
      backgroundColor: AppColors.secondaryButtonColor,
      body: SafeArea(
        child: CommonTabbar(
          pageCount: _pageCount,
          pageController: _pageController,
          tabBarController: _tabController,
          currentIndex: _currentIndex,
          tabbarItemBuilder: (context, index) {
            return _tabbarItems[index];
            // switch (index) {
            //   case 0:
            //     return CommonTabbarItem(
            //       index: index,
            //       // width: MediaQuery.of(context).size.width / 2,
            //       currentIndex: _currentIndex,
            //       title: context.l10n.t_all_events,
            //       hasIcon: false,
            //     );
            //   case 1:
            //     return CommonTabbarItem(
            //       index: index,
            //       // width: MediaQuery.of(context).size.width / _pageCount,
            //       currentIndex: _currentIndex,
            //       title: context.l10n.t_my_diary,
            //       hasIcon: false,
            //     );
            //   case 2:
            //     return CommonTabbarItem(
            //       index: index,
            //       // width: MediaQuery.of(context).size.width / _pageCount,
            //       currentIndex: _currentIndex,
            //       title: context.l10n.t_my_tickets,
            //       hasIcon: false,
            //     );
            //   case 3:
            //     return CommonTabbarItem(
            //       index: index,
            //       // width: MediaQuery.of(context).size.width / _pageCount,
            //       currentIndex: _currentIndex,
            //       title: context.l10n.t_invitations,
            //       hasIcon: false,
            //     );
            //   default:
            //     return const SizedBox();
            // }
          },
          pageViewBuilder: (context, index) {
            switch (index) {
              case 0:
                return const PageTemplateScreen();
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
      ),
    );
  }
}
