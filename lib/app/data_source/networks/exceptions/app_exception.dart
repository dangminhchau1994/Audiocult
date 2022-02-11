class AppException implements Exception {
  dynamic message;

  AppException(this.message);

  @override
  String toString() {
    return message.toString();
  }
}
