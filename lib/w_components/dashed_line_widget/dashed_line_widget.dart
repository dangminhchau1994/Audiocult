import 'package:flutter/material.dart';

// ignore: must_be_immutable
class LineDashedWidget extends StatelessWidget {
  final int? dashWidth;
  final Color? color;
  final int? dashSpace;
  const LineDashedWidget({
    this.dashWidth,
    this.dashSpace,
    this.color,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return CustomPaint(
        painter: _LineDashedPainter(
          constraints.maxWidth,
          dashWidth: dashWidth,
          dashSpace: dashSpace,
          color: color,
        ),
      );
    });
  }
}

class _LineDashedPainter extends CustomPainter {
  final double? width;
  final int? dashWidth;
  final Color? color;
  final int? dashSpace;

  _LineDashedPainter(this.width, {required this.dashWidth, required this.dashSpace, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..strokeWidth = 1
      ..color = Colors.blueGrey.withAlpha(120);
    var max = width ?? 0;
    final _dashWidth = dashWidth ?? 8;
    final _dashSpace = dashSpace ?? 5;
    var startY = 0.0;
    while (max >= 0) {
      canvas.drawLine(Offset(startY, 0), Offset(startY + _dashWidth, 0), paint);
      final space = _dashSpace + _dashWidth;
      startY += space;
      max -= space;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
