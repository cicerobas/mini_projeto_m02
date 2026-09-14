import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:mini_projeto_m02/app/bloc/home/home_bloc.dart';
import 'package:mini_projeto_m02/app/bloc/login/login_bloc.dart';
import 'package:mini_projeto_m02/app/data/datasources/local/auth_local_datasource.dart';
import 'package:mini_projeto_m02/app/data/datasources/local/todo_local_datasource.dart';
import 'package:mini_projeto_m02/app/data/datasources/remote/todo_remote_datasource.dart';
import 'package:mini_projeto_m02/app/data/repositories/auth_repository.dart';
import 'package:mini_projeto_m02/app/data/repositories/todo_repository.dart';
import 'package:mini_projeto_m02/app/shared/app_client.dart';
import 'package:mini_projeto_m02/app/shared/database_helper.dart';
import 'package:sqflite/sqflite.dart';

final depInjection = GetIt.instance;

Future<void> setupDepInjection() async {
  Dio dio = Dio(BaseOptions(baseUrl: 'https://dummyjson.com'));
  Database database = await DatabaseHelper.db;

  depInjection.registerLazySingleton<AppClient>(() => DioAppClientImpl(dio: dio));
  depInjection.registerLazySingleton<Database>(() => database);

  //Datasources
  depInjection.registerFactory<AuthLocalDatasource>(() => AuthLocalDatasource());
  depInjection.registerFactory<TodoLocalDatasource>(() => TodoLocalDatasourceImpl(database: depInjection<Database>()));
  depInjection.registerFactory<TodoRemoteDatasource>(() => TodoRemoteDatasourceImpl(client: depInjection<AppClient>()));

  //Repositories
  depInjection.registerFactory<AuthRepository>(
    () => AuthRepositoryImpl(client: depInjection<AppClient>(), localDatasource: depInjection<AuthLocalDatasource>()),
  );
  depInjection.registerFactory<TodoRepository>(
    () => TodoRepositoryImpl(
      remoteDatasource: depInjection<TodoRemoteDatasource>(),
      localDatasource: depInjection<TodoLocalDatasource>(),
    ),
  );

  //Blocs
  depInjection.registerFactory<LoginBloc>(() => LoginBloc(depInjection<AuthRepository>()));
  depInjection.registerFactory<HomeBloc>(
    () => HomeBloc(authRepository: depInjection<AuthRepository>(), todoRepository: depInjection<TodoRepository>()),
  );
}
