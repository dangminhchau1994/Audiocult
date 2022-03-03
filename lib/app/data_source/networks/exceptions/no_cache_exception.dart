class NoCacheDataException implements Exception {
  dynamic message;

  NoCacheDataException(this.message);

  @override
  String toString() {
    return message.toString();
  }
}
