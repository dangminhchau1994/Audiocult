import 'package:flutter/material.dart';
import 'package:flutter_custom_tab_bar/custom_tab_bar.dart';
import 'package:flutter_custom_tab_bar/indicator/custom_indicator.dart';
import 'package:flutter_custom_tab_bar/indicator/linear_indicator.dart';
import '../../app/utils/constants/app_colors.dart';

class CommonTabbar extends StatelessWidget {
  const CommonTabbar({
    Key? key,
    this.pageCount,
    this.pageController,
    this.tabBarController,
    this.currentIndex,
    this.onTapItem,
    this.onPageChanged,
    this.pageViewBuilder,
    this.tabbarItemBuilder,
  }) : super(key: key);

  final int? pageCount;
  final int? currentIndex;
  final PageController? pageController;
  final CustomTabBarController? tabBarController;
  final Function(int index)? onTapItem;
  final Function(int index)? onPageChanged;
  final IndexedWidgetBuilder? pageViewBuilder;
  final IndexedWidgetBuilder? tabbarItemBuilder;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: AppColors.secondaryButtonColor,
          ),
          child: CustomTabBar(
            tabBarController: tabBarController,
            onTapItem: onTapItem,
            height: 50,
            itemCount: pageCount ?? 0,
            builder: tabbarItemBuilder!, // COMMON TABBAR ITEM GOES HERE
            indicator: LinearIndicator(
              color: AppColors.activeLabelItem,
              bottom: 2,
            ),
            pageController: pageController ?? PageController(),
          ),
        ),
        Expanded(
          child: PageView.builder(
            controller: pageController,
            itemCount: pageCount,
            onPageChanged: onPageChanged,
            itemBuilder: pageViewBuilder!,
          ),
        )
      ],
    );
  }
}
