import 'package:audio_cult/app/features/settings/account_settings/account_settings_screen.dart';
import 'package:audio_cult/app/features/settings/notifications_settings/notification_settings_widget.dart';
import 'package:audio_cult/app/features/settings/page_template/page_template_screen.dart';
import 'package:audio_cult/app/features/settings/privacy_settings/privacy_settings_screen.dart';
import 'package:audio_cult/app/utils/constants/app_assets.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';

import 'package:audio_cult/w_components/appbar/common_appbar.dart';
import 'package:audio_cult/w_components/menus/common_fab_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_tab_bar/indicator/custom_indicator.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../w_components/tabbars/common_tabbar.dart';
import '../../../w_components/tabbars/common_tabbar_item.dart';
import '../../utils/constants/app_colors.dart';
import '../../utils/route/app_route.dart';
import '../../utils/toast/toast_utils.dart';

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

  List<CommonTabbarItem> _initTabbarItems(BuildContext context) {
    return [
      CommonTabbarItem(
        index: 0,
        title: context.localize.t_page_template,
        hasIcon: false,
        currentIndex: _currentIndex,
      ),
      CommonTabbarItem(
        index: 1,
        title: context.localize.t_account,
        hasIcon: false,
        currentIndex: _currentIndex,
      ),
      CommonTabbarItem(
        index: 2,
        title: context.localize.t_privacy,
        hasIcon: false,
        currentIndex: _currentIndex,
      ),
      CommonTabbarItem(
        index: 3,
        title: context.localize.t_notification,
        hasIcon: false,
        currentIndex: _currentIndex,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        actions: [
          // TODO: hidden feature in development
          // Container(
          //   padding: const EdgeInsets.all(8),
          //   margin: const EdgeInsets.symmetric(horizontal: 8),
          //   width: 36,
          //   height: 36,
          //   decoration: BoxDecoration(
          //     color: AppColors.inputFillColor,
          //     shape: BoxShape.circle,
          //   ),
          //   child: SvgPicture.asset(
          //     AppAssets.messageIcon,
          //     fit: BoxFit.cover,
          //   ),
          // ),
          CommonFabMenu(
            onSearchTap: () {
              Navigator.of(context).pushNamed(AppRoute.routeUniversalSearch);
            },
            onNotificationTap: () async {
              await Navigator.pushNamed(context, AppRoute.routeNotification);
            },
            onCartTap: () {
              Navigator.of(context).pushNamed(AppRoute.routeMyCart);
            },
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
          tabbarItemBuilder: (context, index) => _initTabbarItems(context)[index],
          pageViewBuilder: (context, index) {
            switch (index) {
              case 0:
                return const PageTemplateScreen();
              case 1:
                return const AccountSettingsScreen();
              case 2:
                return const PrivacySettingsScreen();
              case 3:
                return const NotificationSettingsWidget();
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
