// Copyright (c) 2021, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:audio_cult/app/utils/constants/app_assets.dart';
import 'package:audio_cult/w_components/bottom_navigation_bar/common_bottom_bar.dart';
import 'package:audio_cult/w_components/buttons/common_button.dart';
import 'package:audio_cult/app/utils/libs/circular_menu_item.dart';
import 'package:audio_cult/w_components/tabbars/common_tabbar_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_custom_tab_bar/custom_tab_bar.dart';
import 'package:flutter_custom_tab_bar/indicator/custom_indicator.dart';
import 'package:flutter_custom_tab_bar/indicator/linear_indicator.dart';
import 'package:flutter_custom_tab_bar/transform/color_transform.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../w_components/menus/common_circular_menu.dart';
import '../../../../w_components/tabbars/common_tabbar.dart';
import '../../../utils/libs/circular_menu.dart';
import '../../../utils/constants/app_colors.dart';
import '../cubit/counter_cubit.dart';

class CounterPage extends StatelessWidget {
  const CounterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CounterCubit(),
      child: const CounterView(),
    );
  }
}

class CounterView extends StatefulWidget {
  const CounterView({Key? key}) : super(key: key);

  @override
  State<CounterView> createState() => _CounterViewState();
}

class _CounterViewState extends State<CounterView> with TickerProviderStateMixin {
  var currentIndex = 0;
  late TabController _tabController;
  final int pageCount = 3;
  final PageController _controller = PageController();
  CustomTabBarController _tabBarController = CustomTabBarController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  void _onItemTapped(int index) {
    if (!mounted) return;
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // final theme = Theme.of(context);
    // final count = context.select((CounterCubit cubit) => cubit.state);
    return Scaffold(
      backgroundColor: AppColors.secondaryButtonColor,
      appBar: AppBar(
        title: Text('Linear Indicator'),
        backgroundColor: AppColors.secondaryButtonColor,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: CommonTabbar(
        pageCount: pageCount,
        pageController: _controller,
        tabBarController: _tabBarController,
        onTapItem: _onItemTapped,
        currentIndex: currentIndex,
        onPageChanged: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        tabbarItemBuilder: (context, index) {
          switch (index) {
            case 0:
              return CommonTabbarItem(
                index: index,
                currentIndex: currentIndex,
                hasIcon: true,
                icon: currentIndex == index
                    ? SvgPicture.asset(
                        AppAssets.activeEdit,
                        width: 24,
                        height: 24,
                      )
                    : SvgPicture.asset(
                        AppAssets.edit,
                        width: 24,
                        height: 24,
                      ),
              );
            case 1:
              return CommonTabbarItem(
                index: index,
                currentIndex: currentIndex,
                hasIcon: true,
                icon: currentIndex == index
                    ? SvgPicture.asset(
                        AppAssets.activePhoto,
                        width: 24,
                        height: 24,
                      )
                    : SvgPicture.asset(
                        AppAssets.photo,
                        width: 24,
                        height: 24,
                      ),
              );
            case 2:
              return CommonTabbarItem(
                index: index,
                currentIndex: currentIndex,
                hasIcon: true,
                icon: currentIndex == index
                    ? SvgPicture.asset(
                        AppAssets.activeVideo,
                        width: 24,
                        height: 24,
                      )
                    : SvgPicture.asset(
                        AppAssets.video,
                        width: 24,
                        height: 24,
                      ),
              );
            default:
              return const SizedBox();
          }
        },
        pageViewBuilder: (context, index) {
          switch (currentIndex) {
            case 0:
              return Center(
                child: Text('sdfsdf', style: TextStyle(color: Colors.white)),
              );
            case 1:
              return Center(
                child: Text('ff', style: TextStyle(color: Colors.white)),
              );
            case 2:
              return Center(
                child: Text('ddd', style: TextStyle(color: Colors.white)),
              );
            default:
              return Container();
          }
        },
      ),
    );
  }
}
