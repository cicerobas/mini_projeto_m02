import 'package:mini_projeto_m02/app/features/auth/domain/repositories/auth_repository.dart';
import 'package:mini_projeto_m02/app/shared/result.dart';
import 'package:mini_projeto_m02/app/shared/usecases.dart';

class LogoutUseCase implements Usecases<void, void> {
  final AuthRepository repository;

  new({required this.repository});

  @override
  Future<Result<void>> call({required void input}) {
    return repository.logout();
  }
}
