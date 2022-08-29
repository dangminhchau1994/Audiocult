import 'package:flutter/material.dart';

class TicketClipper extends CustomClipper<Path> {
  final double punchRadius;
  final double top;
  final double middle;
  TicketClipper(this.punchRadius, this.top, this.middle);

  @override
  Path getClip(Size size) {
    final path = Path();

    path.lineTo(0, top - punchRadius);
    path.conicTo(punchRadius, top - punchRadius, punchRadius, top, 1);
    path.conicTo(punchRadius, top + punchRadius, 0, top + punchRadius, 1);

    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);

    path.lineTo(size.width, top + punchRadius);
    path.conicTo(size.width - punchRadius, top + punchRadius, size.width - punchRadius, top, 1);
    path.conicTo(size.width - punchRadius, top - punchRadius, size.width, top - punchRadius, 1);

    path.lineTo(size.width, 0);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
