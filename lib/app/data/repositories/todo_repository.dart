import 'package:mini_projeto_m02/app/data/datasources/local/todo_local_datasource.dart';
import 'package:mini_projeto_m02/app/data/datasources/remote/todo_remote_datasource.dart';
import 'package:mini_projeto_m02/app/data/models/todo_model.dart';
import 'package:mini_projeto_m02/app/shared/app_client_excepions.dart';
import 'package:mini_projeto_m02/app/shared/app_failures.dart';
import 'package:mini_projeto_m02/app/shared/extensions.dart';
import 'package:mini_projeto_m02/core/result.dart';

sealed class TodoRepository {
  Future<Result<List<TodoModel>>> getTodos(int userId);
  Future<Result<void>> toggleTodoStatus(int todoId, bool completed);
}

class TodoRepositoryImpl implements TodoRepository {
  final TodoRemoteDatasource remoteDatasource;
  final TodoLocalDatasource localDatasource;

  TodoRepositoryImpl({required this.remoteDatasource, required this.localDatasource});

  @override
  Future<Result<List<TodoModel>>> getTodos(int userId) async {
    try {
      final remoteTodos = await remoteDatasource.getUserTodos(userId);
      await localDatasource.saveTodos(remoteTodos);
      final todos = await localDatasource.getUserTodosById(userId);
      return Result.success(todos);
    } on AppClientException catch (e) {
      return Result.failure(e.toFailure());
    } catch (e) {
      return Result.failure(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Result<void>> toggleTodoStatus(int todoId, bool completed) async {
    try {
      await localDatasource.updateTodoStatus(todoId, completed);
      return Result.success(null);
    } catch (e) {
      return Result.failure(UnknownFailure(message: e.toString()));
    }
  }
}
