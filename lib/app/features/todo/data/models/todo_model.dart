import 'dart:convert';

import 'package:mini_projeto_m02/app/features/todo/domain/entities/todo_entity.dart';

class TodoModel extends TodoEntity {
  new({
    required super.id,
    required super.todo,
    required super.completed,
    required super.userId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'todo': todo,
      'completed': completed ? 1 : 0,
      'userId': userId,
    };
  }

  factory TodoModel.fromMap(Map<String, dynamic> map) {
    return TodoModel(
      id: map['id'] as int,
      todo: map['todo'] as String,
      completed: map['completed'] is bool
          ? map['completed']
          : map['completed'] == 1,
      userId: map['userId'] as int,
    );
  }

  factory TodoModel.fromJson(String source) =>
      TodoModel.fromMap(json.decode(source) as Map<String, dynamic>);

  TodoModel copyWith({int? id, String? todo, bool? completed, int? userId}) {
    return TodoModel(
      id: id ?? this.id,
      todo: todo ?? this.todo,
      completed: completed ?? this.completed,
      userId: userId ?? this.userId,
    );
  }
}
