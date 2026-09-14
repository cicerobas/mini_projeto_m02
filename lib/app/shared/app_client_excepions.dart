sealed class AppClientException implements Exception {
  final String message;

  AppClientException({required this.message});
}

class NetworkException extends AppClientException {
  NetworkException({required super.message});
}

class ServerException extends AppClientException {
  final int? statusCode;
  ServerException({required super.message, this.statusCode});
}

class UnknownException extends AppClientException {
  UnknownException({required super.message});
}
