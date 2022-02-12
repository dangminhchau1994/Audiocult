import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../app/utils/constants/app_colors.dart';
import '../../app/utils/extensions/app_extensions.dart';

class CommonBottomBar extends StatelessWidget {
  const CommonBottomBar({
    Key? key,
    this.currentIndex,
    this.onTap,
  }) : super(key: key);

  final int? currentIndex;
  final Function(int index)? onTap;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BottomNavigationBar(
          elevation: 0,
          backgroundColor: HexColor.fromHex('#1F2937'),
          type: BottomNavigationBarType.fixed,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: currentIndex == 0
                  ? SvgPicture.asset('assets/icons/active_home.svg')
                  : SvgPicture.asset('assets/icons/home.svg'),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: currentIndex == 1
                  ? SvgPicture.asset('assets/icons/active_atlas.svg')
                  : SvgPicture.asset('assets/icons/atlas.svg'),
              label: 'Atlas',
            ),
            const BottomNavigationBarItem(
              icon: SizedBox(),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: currentIndex == 3
                  ? SvgPicture.asset('assets/icons/active_music.svg')
                  : SvgPicture.asset('assets/icons/music.svg'),
              label: 'Music',
            ),
            BottomNavigationBarItem(
              icon: currentIndex == 4
                  ? SvgPicture.asset('assets/icons/active_event.svg')
                  : SvgPicture.asset('assets/icons/event.svg'),
              label: 'Events',
            ),
          ],
          currentIndex: currentIndex ?? 0,
          onTap: onTap,
          selectedItemColor: AppColors.activeLabelItem,
          unselectedItemColor: Colors.white,
        ),
      ],
    );
  }
}
