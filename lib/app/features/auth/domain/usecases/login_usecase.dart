import 'package:mini_projeto_m02/app/features/auth/domain/entities/user_entity.dart';
import 'package:mini_projeto_m02/app/features/auth/domain/repositories/auth_repository.dart';
import 'package:mini_projeto_m02/app/shared/result.dart';
import 'package:mini_projeto_m02/app/shared/usecases.dart';

class LoginUseCase implements Usecases<LoginParams, UserEntity> {
  final AuthRepository repository;

  new({required this.repository});

  @override
  Future<Result<UserEntity>> call({required LoginParams input}) {
    return repository.login(username: input.username, password: input.password);
  }
}

class LoginParams {
  final String username;
  final String password;

  const LoginParams({required this.username, required this.password});
}
