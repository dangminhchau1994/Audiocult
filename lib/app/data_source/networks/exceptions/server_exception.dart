import 'api_exception.dart';

class ServerException extends ApiException {
  ServerException(int statusCode, dynamic message, String errorCode)
      : super(message, statusCode: statusCode, errorCode: errorCode);
}
