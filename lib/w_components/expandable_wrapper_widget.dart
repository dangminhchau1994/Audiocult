import 'dart:math' as math;

import 'package:audio_cult/app/utils/constants/app_colors.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';

class ExpandableWrapperWidget extends StatefulWidget {
  final String headerTitle;
  final String? description;
  final Widget child;
  final ExpandableController? controller;
  final EdgeInsets? headerPadding;
  final Color? headerColor;

  const ExpandableWrapperWidget(
    this.headerTitle,
    this.child, {
    this.headerColor,
    this.description,
    this.controller,
    this.headerPadding,
    Key? key,
  }) : super(key: key);

  @override
  State<ExpandableWrapperWidget> createState() => _ExpandableWrapperWidgetState();
}

class _ExpandableWrapperWidgetState extends State<ExpandableWrapperWidget> {
  @override
  Widget build(BuildContext context) {
    return ExpandableNotifier(
      controller: widget.controller,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: ScrollOnExpand(
          child: Column(
            children: <Widget>[
              ExpandablePanel(
                theme: const ExpandableThemeData(
                  headerAlignment: ExpandablePanelHeaderAlignment.center,
                  tapBodyToExpand: false,
                  tapBodyToCollapse: false,
                  tapHeaderToExpand: true,
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
    );
  }

  Widget _headerWidget(BuildContext context) {
    return Container(
      color: widget.headerColor ?? AppColors.ebonyClay,
      padding: widget.headerPadding ?? const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  widget.headerTitle,
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
          if (widget.description?.isNotEmpty == true)
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Text(widget.description!),
            )
          else
            const SizedBox()
        ],
      ),
    );
  }

  Widget _contentWidget(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: widget.headerColor ?? AppColors.ebonyClay),
      padding: const EdgeInsets.only(top: 12),
      child: widget.child,
    );
  }
}
