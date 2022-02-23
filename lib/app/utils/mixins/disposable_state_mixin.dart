import 'package:disposing/disposing.dart';
import 'package:flutter/material.dart';

mixin DisposableStateMixin<T extends StatefulWidget> on State<T> {
  final disposeBag = DisposableBag();

  @override
  void dispose() {
    _disposeInternal();
    super.dispose();
  }

  // ignore: avoid_void_async
  void _disposeInternal() async {
    await disposeBag.dispose();
  }
}
