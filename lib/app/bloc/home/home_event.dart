import 'package:mini_projeto_m02/app/bloc/home/home_state.dart';

sealed class HomeEvent {}

class HomeStarted extends HomeEvent {}

class HomeRetryRequested extends HomeEvent {}

class HomeFilterChanged extends HomeEvent {
  final TodoFilter filter;
  HomeFilterChanged(this.filter);
}

class HomeSearchChanged extends HomeEvent {
  final String query;
  HomeSearchChanged(this.query);
}

class HomeTodoToggled extends HomeEvent {
  final int todoId;
  HomeTodoToggled(this.todoId);
}

class HomeLogoutRequested extends HomeEvent {}
