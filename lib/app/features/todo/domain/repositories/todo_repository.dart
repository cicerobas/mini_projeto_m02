import 'package:mini_projeto_m02/app/features/todo/domain/entities/todo_entity.dart';
import 'package:mini_projeto_m02/app/shared/result.dart';

abstract interface class TodoRepository {
  Future<Result<List<TodoEntity>>> getTodos(int userId);
  Future<Result<void>> toggleTodoStatus(int todoId, bool completed);
}
