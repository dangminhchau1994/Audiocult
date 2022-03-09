import 'package:audio_cult/app/base/bloc_handle.dart';
import 'package:audio_cult/app/features/main/main_bloc.dart';
import 'package:audio_cult/app/features/music/music_screen.dart';
import 'package:audio_cult/app/injections.dart';
import 'package:audio_cult/w_components/bottom_navigation_bar/common_bottom_bar.dart';
import 'package:audio_cult/w_components/menus/common_circular_menu.dart';
import 'package:flutter/material.dart';

import '../../../di/bloc_locator.dart';
import '../../utils/constants/app_colors.dart';
import '../menu_settings/drawer/my_drawer.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  var _currentIndex = 0;
  final GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  final _pageController = PageController();
  final MainBloc _mainBloc = locator.get();
  @override
  void initState() {
    super.initState();
    _mainBloc.getUserProfile();
  }

  List<Widget> _buildPages() {
    final pages = <Widget>[];
    pages.add(
      const SizedBox(
        child: Center(
          child: Text('Home Screen'),
        ),
      ),
    );
    pages.add(
      const SizedBox(
        child: Center(
          child: Text('Atlas Screen'),
        ),
      ),
    );
    pages.add(
      const SizedBox(),
    );
    pages.add(
      MusicScreen(
        onPressAvatar: () {
          _drawerKey.currentState?.openDrawer();
        },
      ),
    );
    pages.add(
      const SizedBox(
        child: Center(
          child: Text('Event Screen'),
        ),
      ),
    );
    return pages;
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocHandle(
      bloc: getIt.get<MainBloc>(),
      child: Scaffold(
        key: _drawerKey,
        drawerScrimColor: Colors.transparent,
        drawer: SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          child: const Drawer(
            backgroundColor: Colors.transparent,
            child: MyDrawer(),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: PageView(
                physics: const NeverScrollableScrollPhysics(),
                controller: _pageController,
                children: _buildPages(),
              ),
            ),
          ],
        ),
        backgroundColor: AppColors.mainColor,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: CommonCircularMenu(
          onMusicTap: () {},
          onEventTap: () {},
          onPostTap: () {},
        ),
        bottomNavigationBar: CommonBottomBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
            _pageController.jumpToPage(index);
          },
        ),
      ),
    );
  }
}
