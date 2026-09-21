import 'package:mini_projeto_m02/app/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:mini_projeto_m02/app/features/auth/data/models/user_model.dart';
import 'package:mini_projeto_m02/app/features/auth/domain/entities/user_entity.dart';
import 'package:mini_projeto_m02/app/features/auth/domain/repositories/auth_repository.dart';
import 'package:mini_projeto_m02/app/shared/app_client.dart';
import 'package:mini_projeto_m02/app/shared/app_client_excepions.dart';
import 'package:mini_projeto_m02/app/shared/app_failures.dart';
import 'package:mini_projeto_m02/app/shared/extensions.dart';
import 'package:mini_projeto_m02/app/shared/result.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AppClient client;
  final AuthLocalDatasource localDatasource;

  new({required this.client, required this.localDatasource});

  @override
  Future<Result<UserEntity>> login({
    required String username,
    required String password,
  }) async {
    try {
      final data = await client.post(
        "/auth/login",
        body: {"username": username, "password": password},
      );
      final user = UserModel.fromMap(data);
      await localDatasource.saveUser(user.toMap());

      return Result.success(user);
    } on AppClientException catch (e) {
      return Result.failure(e.toFailure());
    } catch (e) {
      return Result.failure(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Result<UserEntity?>> getSavedUser() async {
    try {
      final result = await localDatasource.getUser();
      final user = result != null ? UserModel.fromMap(result) : null;
      return Result.success(user);
    } catch (e) {
      return Result.failure(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Result<void>> logout() async {
    try {
      await localDatasource.clearUser();
      return Result.success(null);
    } catch (e) {
      return Result.failure(UnknownFailure(message: e.toString()));
    }
  }
}
