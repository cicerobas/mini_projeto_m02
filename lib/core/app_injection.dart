import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:mini_projeto_m02/app/bloc/login/login_bloc.dart';
import 'package:mini_projeto_m02/app/data/datasources/local/auth_local_datasource.dart';
import 'package:mini_projeto_m02/app/data/repositories/auth_repository.dart';
import 'package:mini_projeto_m02/app/shared/app_client.dart';

final depInjection = GetIt.instance;

void setupDepInjection() {
  Dio dio = Dio(BaseOptions(baseUrl: 'https://dummyjson.com'));
  depInjection.registerLazySingleton<AppClient>(() => DioAppClientImpl(dio: dio));

  depInjection.registerLazySingleton<AuthLocalDatasource>(() => AuthLocalDatasource());
  depInjection.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(client: depInjection<AppClient>(), localDatasource: depInjection<AuthLocalDatasource>()),
  );

  depInjection.registerFactory<LoginBloc>(() => LoginBloc(depInjection<AuthRepository>()));
}
