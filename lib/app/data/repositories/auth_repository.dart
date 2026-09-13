import 'package:mini_projeto_m02/app/data/datasources/local/auth_local_datasource.dart';
import 'package:mini_projeto_m02/app/data/models/user_model.dart';
import 'package:mini_projeto_m02/app/shared/app_client.dart';
import 'package:mini_projeto_m02/app/shared/app_client_excepions.dart';
import 'package:mini_projeto_m02/app/shared/app_failures.dart';
import 'package:mini_projeto_m02/app/shared/extensions.dart';
import 'package:mini_projeto_m02/core/result.dart';

sealed class AuthRepository {
  Future<Result<UserModel?>> getSavedUser();
  Future<Result<UserModel>> login({required String username, required String password});
}

class AuthRepositoryImpl implements AuthRepository {
  final AppClient client;
  final AuthLocalDatasource localDatasource;

  AuthRepositoryImpl({required this.client, required this.localDatasource});

  @override
  Future<Result<UserModel>> login({required String username, required String password}) async {
    try {
      final data = await client.post("/auth/login", body: {"username": username, "password": password});
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
  Future<Result<UserModel?>> getSavedUser() async {
    try {
      final result = await localDatasource.getUser();
      final user = result != null ? UserModel.fromMap(result) : null;
      return Result.success(user);
    } catch (e) {
      return Result.failure(UnknownFailure(message: e.toString()));
    }
  }
}
