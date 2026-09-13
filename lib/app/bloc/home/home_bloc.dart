import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_projeto_m02/app/bloc/home/home_event.dart';
import 'package:mini_projeto_m02/app/bloc/home/home_state.dart';
import 'package:mini_projeto_m02/app/data/models/user_model.dart';
import 'package:mini_projeto_m02/app/data/repositories/auth_repository.dart';
import 'package:mini_projeto_m02/app/data/repositories/todo_repository.dart';
import 'package:mini_projeto_m02/core/result.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final AuthRepository authRepository;
  final TodoRepository todoRepository;

  HomeBloc({required this.authRepository, required this.todoRepository}) : super(const HomeState()) {
    on<HomeStarted>(_onHomeStarted);
    on<HomeRetryRequested>(_onHomeStarted);
  }

  Future<void> _onHomeStarted(HomeEvent event, Emitter<HomeState> emit) async {
    emit(state.copyWith(status: HomeStatus.loading));

    final userResult = await authRepository.getSavedUser();
    switch (userResult) {
      case Success(value: final user):
        if (user == null) {
          emit(state.copyWith(status: HomeStatus.error, errorMessage: "Usuário não encontrado"));
          return;
        }
        await _loadTodos(user, emit);
      case Failure(error: final failure):
        emit(state.copyWith(status: HomeStatus.error, errorMessage: failure.message));
    }
  }

  Future<void> _loadTodos(UserModel user, Emitter<HomeState> emit) async {
    final todosResult = await todoRepository.getTodos(user.id);

    switch (todosResult) {
      case Success(value: final todos):
        emit(state.copyWith(status: HomeStatus.success, userName: '${user.firstName} ${user.lastName}', todos: todos));
      case Failure(error: final failure):
        emit(
          state.copyWith(
            status: HomeStatus.error,
            userName: '${user.firstName} ${user.lastName}',
            errorMessage: failure.message,
          ),
        );
    }
  }
}
