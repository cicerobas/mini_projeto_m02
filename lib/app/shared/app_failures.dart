sealed class AppFailure {
  final String message;

  AppFailure({required this.message});
}

class NetworkFailure extends AppFailure {
  NetworkFailure({required super.message});
}

class ServerFailure extends AppFailure {
  final int? statusCode;

  ServerFailure({required super.message, this.statusCode});
}

class UnknownFailure extends AppFailure {
  UnknownFailure({required super.message});
}
