import 'package:audio_cult/app/features/music/music_screen.dart';
import 'package:audio_cult/w_components/bottom_navigation_bar/common_bottom_bar.dart';
import 'package:audio_cult/w_components/menus/common_circular_menu.dart';
import 'package:flutter/material.dart';

import '../../utils/constants/app_colors.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  var _currentIndex = 0;

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
      const MusicScreen(),
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
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _buildPages(),
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
        },
      ),
    );
  }
}
