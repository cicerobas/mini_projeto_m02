import 'package:mini_projeto_m02/app/shared/app_failures.dart';

sealed class Result<T> {
  const Result();

  const factory Result.success(T value) = Success._;

  const factory Result.failure(AppFailure error) = Failure._;
}

final class Success<T> extends Result<T> {
  const Success._(this.value);

  final T value;
}

final class Failure<T> extends Result<T> {
  const Failure._(this.error);

  final AppFailure error;
}
