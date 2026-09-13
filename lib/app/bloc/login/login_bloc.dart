import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_projeto_m02/app/bloc/login/login_event.dart';
import 'package:mini_projeto_m02/app/bloc/login/login_state.dart';
import 'package:mini_projeto_m02/app/data/repositories/auth_repository.dart';
import 'package:mini_projeto_m02/app/shared/app_failures.dart';
import 'package:mini_projeto_m02/core/result.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository repository;

  LoginBloc(this.repository) : super(LoginInitial()) {
    on<LoginSubmitted>((event, emit) async {
      emit(LoginLoading());

      final result = await repository.login(username: event.username, password: event.password);
      switch (result) {
        case Success():
          emit(LoginSuccess());
        case Failure(error: final failure):
          emit(LoginError(_mapFailureMessage(failure)));
      }
    });
  }
  String _mapFailureMessage(AppFailure failure) {
    return switch (failure) {
      ServerFailure(statusCode: 400) => 'Usuário ou senha inválidos',
      ServerFailure() => 'Erro no servidor, tente novamente',
      NetworkFailure() => 'Falha de conexão, verifique sua internet',
      UnknownFailure() => 'Ocorreu um erro inesperado',
    };
  }
}
