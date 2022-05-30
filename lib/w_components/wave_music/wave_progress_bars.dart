library wave_progress_bars;

import 'dart:math';

import 'package:audio_cult/w_components/wave_music/single_bar_painter.dart';
import 'package:flutter/material.dart';

import 'background_painter.dart';

class WaveProgressBar extends StatefulWidget {
  final double progressPercentage;
  final List<double> listOfHeights;
  final double width;
  final Color initialColor;
  final Color progressColor;
  final Color backgroundColor;
  final int timeInMilliSeconds;
  final bool isVerticallyAnimated;
  final bool isHorizontallyAnimated;

  const WaveProgressBar({
    Key? key,
    this.isVerticallyAnimated = true,
    this.isHorizontallyAnimated = true,
    required this.listOfHeights,
    this.initialColor = Colors.red,
    this.progressColor = Colors.green,
    this.backgroundColor = Colors.white,
    required this.width,
    required this.progressPercentage,
    this.timeInMilliSeconds = 20000,
  }) : super(key: key);

  @override
  WaveProgressBarState createState() {
    return WaveProgressBarState();
  }
}

class WaveProgressBarState extends State<WaveProgressBar> with SingleTickerProviderStateMixin {
  final List<Widget> arrayOfBars = [];
  Animation<double>? horizontalAnimation;
  Animation<double>? verticalAnimation;
  AnimationController? controller;
  double? begin;
  double? end;

  @override
  void initState() {
    begin = 0;
    end = widget.width;

    super.initState();
    controller = AnimationController(duration: Duration(milliseconds: widget.timeInMilliSeconds), vsync: this);

    horizontalAnimation = Tween(begin: begin, end: end).animate(controller!)
      ..addListener(() {
        setState(() {});
      });
    controller?.forward();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    arrayOfBars.add(Container(
      child: CustomPaint(
        painter: BackgroundBarPainter(
          widthOfContainer: (widget.isHorizontallyAnimated) ? horizontalAnimation!.value : widget.width,
          heightOfContainer: widget.listOfHeights.reduce(max),
          progressPercentage: widget.progressPercentage,
          initialColor: widget.initialColor,
          progressColor: widget.progressColor,
        ),
      ),
    ));

    for (var i = 0; i < widget.listOfHeights.length; i++) {
      // ignore: prefer_int_literals
      verticalAnimation = Tween(begin: 0.0, end: widget.listOfHeights[i]).animate(controller!)
        ..addListener(() {
          setState(() {});
        });
      controller?.forward();
      arrayOfBars.add(
        Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
          child: CustomPaint(
            painter: SingleBarPainter(
                // ignore: unnecessary_parenthesis
                startingPosition: i * ((widget.width / widget.listOfHeights.length)),
                singleBarWidth: widget.width / widget.listOfHeights.length,
                maxSeekBarHeight: widget.listOfHeights.reduce(max) + 1,
                actualSeekBarHeight: (widget.isVerticallyAnimated) ? verticalAnimation!.value : widget.listOfHeights[i],
                heightOfContainer: widget.listOfHeights.reduce(max),
                backgroundColor: widget.backgroundColor),
          ),
        ),
      );
    }

    return Center(
      child: SizedBox(
          height: widget.listOfHeights.reduce(max),
          width: widget.width,
          child: Row(
            children: arrayOfBars,
          )),
    );
  }
}
