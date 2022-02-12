import 'app_exception.dart';

class NoInternetException extends AppException {
  NoInternetException() : super('Không có kết nối internet');
}
