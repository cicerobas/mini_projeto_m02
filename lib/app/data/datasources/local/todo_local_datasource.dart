import 'package:mini_projeto_m02/app/data/models/todo_model.dart';
import 'package:sqflite/sqlite_api.dart';

sealed class TodoLocalDatasource {
  Future<void> saveTodos(List<TodoModel> todos);
  Future<List<TodoModel>> getUserTodosById(int userId);
}

class TodoLocalDatasourceImpl implements TodoLocalDatasource {
  final Database database;

  TodoLocalDatasourceImpl({required this.database});

  @override
  Future<List<TodoModel>> getUserTodosById(int userId) async {
    final data = await database.query("todos", where: "userId = ?", whereArgs: [userId]);
    return data.map((item) => TodoModel.fromMap(item)).toList();
  }

  @override
  Future<void> saveTodos(List<TodoModel> todos) async {
    final batch = database.batch();

    for (final todo in todos) {
      batch.insert("todos", todo.toMap(), conflictAlgorithm: .ignore);
    }

    await batch.commit(noResult: true);
  }
}
