import 'package:audio_cult/app/features/universal_search/universal_search_tab/universal_search_all_screen.dart';
import 'package:audio_cult/app/features/universal_search/universal_search_tab/universal_search_event_screen.dart';
import 'package:audio_cult/app/features/universal_search/universal_search_tab/universal_search_message_screen.dart';
import 'package:audio_cult/app/features/universal_search/universal_search_tab/universal_search_music_screen.dart';
import 'package:audio_cult/app/features/universal_search/universal_search_tab/universal_search_people_screen.dart';
import 'package:audio_cult/app/features/universal_search/universal_search_tab/universal_search_post_screen.dart';
import 'package:audio_cult/app/utils/constants/app_assets.dart';
import 'package:audio_cult/app/utils/constants/app_colors.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:audio_cult/l10n/l10n.dart';
import 'package:audio_cult/w_components/tabbars/common_tabbar.dart';
import 'package:audio_cult/w_components/tabbars/common_tabbar_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_tab_bar/indicator/custom_indicator.dart';
import 'package:flutter_svg/flutter_svg.dart';

class UniversalSearchScreen extends StatefulWidget {
  const UniversalSearchScreen({Key? key}) : super(key: key);

  @override
  State<UniversalSearchScreen> createState() => _UniversalSearchScreenState();
}

class _UniversalSearchScreenState extends State<UniversalSearchScreen> {
  final _tabbarItems = <CommonTabbarItem>[];

  final _tabController = CustomTabBarController();

  final _pageController = PageController();
  final _searchTextFieldController = TextEditingController();
  final _universalSearchAllKey = GlobalKey<UniversalSearchAllScreenState>();
  final _universalSearchMusicKey = GlobalKey<UniversalSearchMusicScreenState>();
  final _universalSearchEventsKey = GlobalKey<UniversalSearchEventScreenState>();
  final _universalSearchPeopleKey = GlobalKey<UniversalSearchPeopleScreenState>();
  final _universalSearchPostKey = GlobalKey<UniversalSearchPostScreenState>();
  final _universalSearchMessageKey = GlobalKey<UniversalSearchMessageScreenState>();

  var _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _searchTextFieldController.addListener(() {
      // _universalSearchAllKey.currentState?.dosomething();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _initTabbarItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      body: SafeArea(
        child: Column(
          children: [
            Container(height: 12, color: AppColors.secondaryButtonColor),
            _searchBar(),
            Container(height: 12, color: AppColors.secondaryButtonColor),
            Expanded(child: _body()),
          ],
        ),
      ),
    );
  }

  void _initTabbarItems() {
    _tabbarItems.addAll([
      CommonTabbarItem(index: 0, title: context.l10n.t_all, hasIcon: false),
      CommonTabbarItem(index: 1, title: context.l10n.t_music, hasIcon: false),
      CommonTabbarItem(index: 2, title: context.l10n.t_events, hasIcon: false),
      CommonTabbarItem(index: 3, title: context.l10n.t_people, hasIcon: false),
      CommonTabbarItem(index: 4, title: context.l10n.t_post, hasIcon: false),
      CommonTabbarItem(index: 5, title: context.l10n.t_message, hasIcon: false),
    ]);
  }

  Widget _searchBar() {
    return Container(
      height: 50,
      padding: const EdgeInsets.only(left: 12, right: 8),
      color: AppColors.secondaryButtonColor,
      child: _searchTextField(),
    );
  }

  Widget _searchTextField() {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 82),
          child: Container(
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: AppColors.mainColor,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 1),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: SvgPicture.asset(AppAssets.whiteSearchIcon),
              ),
              const SizedBox(width: 12),
              Flexible(
                child: TextField(
                  controller: _searchTextFieldController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: context.l10n.t_search,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 2),
                child: _clearTextSearchButton(),
              ),
              _cancelButton(),
            ],
          ),
        )
      ],
    );
  }

  Widget _cancelButton() {
    return SizedBox(
      width: 80,
      child: TextButton(
        onPressed: Navigator.of(context).pop,
        child: Text(
          context.l10n.t_cancel,
          style: context.buttonTextStyle(),
        ),
      ),
    );
  }

  Widget _clearTextSearchButton() {
    return IconButton(
      onPressed: _searchTextFieldController.clear,
      icon: SvgPicture.asset(
        AppAssets.icClear,
        fit: BoxFit.fill,
      ),
    );
  }

  Widget _body() {
    return CommonTabbar(
      pageCount: _tabbarItems.length,
      pageController: _pageController,
      tabBarController: _tabController,
      currentIndex: _currentIndex,
      tabbarItemBuilder: (context, index) => _tabbarItems[index],
      pageViewBuilder: (context, index) {
        switch (index) {
          case 0:
            return UniversalSearchAllScreen(key: _universalSearchAllKey);
          case 1:
            return UniversalSearchMusicScreen(key: _universalSearchMusicKey);
          case 2:
            return UniversalSearchEventScreen(key: _universalSearchEventsKey);
          case 3:
            return UniversalSearchPeopleScreen(key: _universalSearchPeopleKey);
          case 4:
            return UniversalSearchPostScreen(key: _universalSearchPostKey);
          default:
            return UniversalSearchMessageScreen(key: _universalSearchMessageKey);
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
    );
  }
}
