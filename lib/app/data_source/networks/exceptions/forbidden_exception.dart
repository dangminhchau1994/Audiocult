import 'api_exception.dart';

class ForbiddenException extends ApiException {
  ForbiddenException(int statusCode, dynamic message)
      : super(message, statusCode: statusCode);
}
