import 'dart:convert';

class TodoModel {
  final int id;
  final String todo;
  final bool completed;
  final int userId;

  TodoModel({required this.id, required this.todo, required this.completed, required this.userId});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'id': id, 'todo': todo, 'completed': completed ? 1 : 0, 'userId': userId};
  }

  factory TodoModel.fromMap(Map<String, dynamic> map) {
    return TodoModel(
      id: map['id'] as int,
      todo: map['todo'] as String,
      completed: map['completed'] is bool ? map['completed'] : map['completed'] == 1,
      userId: map['userId'] as int,
    );
  }

  factory TodoModel.fromJson(String source) => TodoModel.fromMap(json.decode(source) as Map<String, dynamic>);

  TodoModel copyWith({int? id, String? todo, bool? completed, int? userId}) {
    return TodoModel(
      id: id ?? this.id,
      todo: todo ?? this.todo,
      completed: completed ?? this.completed,
      userId: userId ?? this.userId,
    );
  }
}
