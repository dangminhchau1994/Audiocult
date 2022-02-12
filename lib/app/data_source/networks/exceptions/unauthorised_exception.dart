import 'api_exception.dart';

class UnauthorisedException extends ApiException {
  UnauthorisedException(int statusCode, dynamic message, String errorCode)
      : super(message, statusCode: statusCode, errorCode: errorCode);
}
