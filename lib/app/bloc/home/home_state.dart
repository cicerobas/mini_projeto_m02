import 'package:mini_projeto_m02/app/data/models/todo_model.dart';

enum HomeStatus { initial, loading, success, error, loggedOut }

enum TodoFilter { all, completed, incomplete }

class HomeState {
  final HomeStatus status;
  final String userName;
  final List<TodoModel> todos;
  final TodoFilter filter;
  final String searchQuery;
  final String? errorMessage;

  const HomeState({
    this.status = HomeStatus.initial,
    this.userName = "",
    this.todos = const [],
    this.filter = TodoFilter.all,
    this.searchQuery = "",
    this.errorMessage,
  });

  List<TodoModel> get filteredTodoList {
    return todos.where((todo) {
      final matchesFilter = switch (filter) {
        TodoFilter.all => true,
        TodoFilter.completed => todo.completed,
        TodoFilter.incomplete => !todo.completed,
      };

      final matchesQuery = searchQuery.isEmpty || todo.todo.toLowerCase().contains(searchQuery.toLowerCase());

      return matchesFilter && matchesQuery;
    }).toList();
  }

  HomeState copyWith({
    HomeStatus? status,
    String? userName,
    List<TodoModel>? todos,
    TodoFilter? filter,
    String? searchQuery,
    String? errorMessage,
  }) {
    return HomeState(
      status: status ?? this.status,
      userName: userName ?? this.userName,
      todos: todos ?? this.todos,
      filter: filter ?? this.filter,
      searchQuery: searchQuery ?? this.searchQuery,
      errorMessage: errorMessage,
    );
  }
}
