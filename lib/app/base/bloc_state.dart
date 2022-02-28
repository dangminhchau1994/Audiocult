import 'package:freezed_annotation/freezed_annotation.dart';

part 'bloc_state.freezed.dart';

@freezed
class BlocState<T> with _$BlocState {
  const factory BlocState.success(T data) = Success;
  const factory BlocState.loading() = Loading;
  const factory BlocState.error(String message) = Error;
}
