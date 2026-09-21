import 'package:mini_projeto_m02/app/features/todo/data/models/todo_model.dart';
import 'package:mini_projeto_m02/app/shared/app_client.dart';

abstract interface class TodoRemoteDatasource {
  Future<List<TodoModel>> getUserTodos(int userId);
}

class TodoRemoteDatasourceImpl implements TodoRemoteDatasource {
  final AppClient client;

  new({required this.client});

  @override
  Future<List<TodoModel>> getUserTodos(int userId) async {
    final data = await client.get("/todos/user/$userId");
    return (data["todos"] as List)
        .map((item) => TodoModel.fromMap(item))
        .toList();
  }
}
