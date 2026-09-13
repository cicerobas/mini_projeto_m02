import 'package:mini_projeto_m02/app/shared/app_client_excepions.dart';
import 'package:mini_projeto_m02/app/shared/app_failures.dart';

extension ConvertExceptionToFailure on AppClientException {
  AppFailure toFailure() {
    return switch (this) {
      NetworkException() => NetworkFailure(message: message),
      ServerException(:final statusCode) => ServerFailure(message: message, statusCode: statusCode),
      UnknownException() => UnknownFailure(message: message),
    };
  }
}
