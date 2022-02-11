import 'api_exception.dart';

class BadRequestException extends ApiException {
  BadRequestException(int statusCode, dynamic message)
      : super(message, statusCode: statusCode);
}
