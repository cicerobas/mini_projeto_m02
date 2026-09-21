import 'package:mini_projeto_m02/app/features/auth/domain/entities/user_entity.dart';
import 'package:mini_projeto_m02/app/features/auth/domain/repositories/auth_repository.dart';
import 'package:mini_projeto_m02/app/shared/result.dart';
import 'package:mini_projeto_m02/app/shared/usecases.dart';

class GetSavedUserUseCase implements Usecases<void, UserEntity?> {
  final AuthRepository repository;

  new({required this.repository});

  @override
  Future<Result<UserEntity?>> call({required void input}) {
    return repository.getSavedUser();
  }
}
