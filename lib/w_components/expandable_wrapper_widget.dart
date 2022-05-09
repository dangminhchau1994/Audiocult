import 'dart:math' as math;

import 'package:audio_cult/app/utils/constants/app_colors.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';

class ExpandableWrapperWidget extends StatelessWidget {
  final String headerTitle;
  final Widget child;

  const ExpandableWrapperWidget(
    this.headerTitle,
    this.child, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpandableNotifier(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: ScrollOnExpand(
          child: Card(
            clipBehavior: Clip.antiAlias,
            color: Colors.transparent,
            child: Column(
              children: <Widget>[
                ExpandablePanel(
                  theme: const ExpandableThemeData(
                    headerAlignment: ExpandablePanelHeaderAlignment.center,
                    tapBodyToExpand: true,
                    tapBodyToCollapse: false,
                    hasIcon: false,
                  ),
                  header: _headerWidget(context),
                  collapsed: Container(),
                  expanded: _contentWidget(context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _headerWidget(BuildContext context) {
    return Container(
      color: AppColors.mainColor,
      child: Row(
        children: [
          Expanded(
            child: Text(
              headerTitle,
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                  ),
            ),
          ),
          ExpandableIcon(
            theme: const ExpandableThemeData(
              expandIcon: Icons.arrow_drop_down_rounded,
              collapseIcon: Icons.arrow_drop_up_rounded,
              iconColor: Colors.white,
              iconSize: 28,
              iconRotationAngle: math.pi / 2,
              iconPadding: EdgeInsets.only(right: 5),
              hasIcon: false,
            ),
          ),
        ],
      ),
    );
  }

  Widget _contentWidget(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 12),
      color: AppColors.mainColor,
      child: child,
    );
  }
}
