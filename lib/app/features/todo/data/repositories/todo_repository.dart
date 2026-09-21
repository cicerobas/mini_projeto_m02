import 'package:mini_projeto_m02/app/features/todo/domain/entities/todo_entity.dart';
import 'package:mini_projeto_m02/app/features/todo/domain/repositories/todo_repository.dart';
import 'package:mini_projeto_m02/app/shared/result.dart';

class TodoRepositoryImpl implements TodoRepository {
  final TodoRemoteDatasource remoteDatasource;
  final TodoLocalDatasource localDatasource;

  @override
  Future<Result<List<TodoEntity>>> getTodos(int userId) {
    // TODO: implement getTodos
    throw UnimplementedError();
  }

  @override
  Future<Result<void>> toggleTodoStatus(int todoId, bool completed) {
    // TODO: implement toggleTodoStatus
    throw UnimplementedError();
  }
}
