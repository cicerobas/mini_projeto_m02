import 'package:mini_projeto_m02/app/shared/result.dart';

abstract interface class Usecases<Input, Output> {
  Future<Result<Output>> call({required Input input});
}
