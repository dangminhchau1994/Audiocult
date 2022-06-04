import 'package:flutter/material.dart';

extension StringExtension on String {
  List<TextSpan> highlightOccurrences(String query) {
    if (query.isEmpty || !toLowerCase().contains(query.toLowerCase())) {
      return [TextSpan(text: this)];
    }
    final matches = query.toLowerCase().allMatches(toLowerCase());

    var lastMatchEnd = 0;

    final children = <TextSpan>[];
    for (var i = 0; i < matches.length; i++) {
      final match = matches.elementAt(i);

      if (match.start != lastMatchEnd) {
        children.add(TextSpan(
          text: substring(lastMatchEnd, match.start),
        ));
      }

      children.add(TextSpan(
          text: substring(match.start, match.end),
          style: TextStyle(background: Paint()..color = Colors.redAccent.withAlpha(100))));

      if (i == matches.length - 1 && match.end != length) {
        children.add(TextSpan(
          text: substring(match.end, length),
        ));
      }

      lastMatchEnd = match.end;
    }
    return children;
  }
}
