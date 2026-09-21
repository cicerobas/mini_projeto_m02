import 'package:mini_projeto_m02/app/features/auth/domain/entities/user_entity.dart';
import 'package:mini_projeto_m02/app/shared/result.dart';

abstract interface class AuthRepository {
  Future<Result<UserEntity?>> getSavedUser();
  Future<Result<UserEntity>> login({
    required String username,
    required String password,
  });
  Future<Result<void>> logout();
}
