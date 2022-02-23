import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

class LoadingWidget extends StatefulWidget {
  final Color backgroundColor;
  const LoadingWidget({Key? key, this.backgroundColor = Colors.transparent}) : super(key: key);

  @override
  _LoadingWidgetState createState() => _LoadingWidgetState();
}

class _LoadingWidgetState extends State<LoadingWidget> {
  final List<Color> _kDefaultRainbowColors = const [
    Colors.red,
    Colors.orange,
    Colors.yellow,
    Colors.green,
    Colors.blue,
    Colors.indigo,
    Colors.purple,
  ];
  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: true,
      child: Container(
        color: widget.backgroundColor,
        child: Center(
          child: SizedBox(
            width: 72.0,
            child: LoadingIndicator(
              colors: _kDefaultRainbowColors,
              indicatorType: ([
                Indicator.ballPulseSync,
                Indicator.ballPulse,
                Indicator.ballBeat,
                Indicator.ballPulseRise,
              ]..shuffle())
                  .first,
            ),
          ),
        ),
      ),
    );
  }
}
