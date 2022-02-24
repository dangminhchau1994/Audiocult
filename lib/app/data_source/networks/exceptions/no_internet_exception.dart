import 'app_exception.dart';

class NoInternetException extends AppException {
  NoInternetException() : super('No internet connection!');
}
