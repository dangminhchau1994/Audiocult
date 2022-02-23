abstract class AppState {}

class InitialState extends AppState {}

class LoadingState extends AppState {}

class ErrorState<TParams> extends AppState {
  final String? message;
  final TParams? params;

  ErrorState({this.message, this.params});
}

class EmptyDataState<TParams> extends AppState {
  final String? message;
  final TParams? params;

  EmptyDataState({this.message, this.params});
}

class DataLoadedState<TParams, TModel> extends AppState {
  final TParams? params;
  final TModel? data;

  DataLoadedState({this.params, this.data});
}
