class NetworkException implements Exception {
  final int? statusCode;
  final String message;
  final Object? raw;

  NetworkException({this.statusCode, required this.message, this.raw});

  @override
  String toString() => 'NetworkException($statusCode, $message)';
}

class ParsingException implements Exception {
  final String message;

  ParsingException(this.message);

  @override
  String toString() => 'ParsingException($message)';
}

class CacheException implements Exception {
  final String message;

  CacheException(this.message);

  @override
  String toString() => 'CacheException($message)';
}
