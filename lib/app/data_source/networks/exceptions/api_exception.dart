import 'app_exception.dart';

class ApiException extends AppException {
  final int? statusCode;
  final String? errorCode;
  final String? body;

  ApiException(dynamic message, {this.errorCode, this.statusCode, this.body})
      : super(message);
}
