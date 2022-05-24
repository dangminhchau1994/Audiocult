import 'dart:async';

import 'package:audio_cult/app/base/base_bloc.dart';
import 'package:dartz/dartz.dart';

class SubscribeUserBloc extends BaseBloc {
  final _subscritionOnChangeStreamController = StreamController<Tuple2<String, Type>>.broadcast();
  Stream<Tuple2<String, Type>> get subsriptionOnChangeStream => _subscritionOnChangeStreamController.stream;

  SubscribeUserBloc();

  void subscriptionOnChange(String userId, Type type) {
    _subscritionOnChangeStreamController.sink.add(Tuple2(userId, type));
  }
}
