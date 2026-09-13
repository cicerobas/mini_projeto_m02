import 'package:dio/dio.dart';
import 'package:mini_projeto_m02/app/shared/app_client_excepions.dart';

sealed class AppClient {
  Future<dynamic> get(String url);
  Future<dynamic> post(String url, {Map<String, dynamic> body});
}

class DioAppClientImpl extends AppClient {
  final Dio dio;

  DioAppClientImpl({required this.dio});

  @override
  Future<dynamic> get(String url) async {
    try {
      final response = await dio.get(url);
      return response.data;
    } on DioException catch (e) {
      throw _mapToAppClientException(e);
    }
  }

  @override
  Future<dynamic> post(String url, {Map<String, dynamic>? body}) async {
    try {
      final response = await dio.post(url, data: body);
      return response.data;
    } on DioException catch (e) {
      throw _mapToAppClientException(e);
    }
  }

  AppClientException _mapToAppClientException(DioException e) {
    return switch (e.type) {
      .connectionTimeout ||
      .sendTimeout ||
      .receiveTimeout ||
      .connectionError => NetworkException(message: 'Falha na conexão com o servidor'),
      .badResponse => ServerException(
        message: e.response?.data?['message']?.toString() ?? 'Erro no servidor',
        statusCode: e.response?.statusCode,
      ),
      _ => UnknownException(message: 'Erro desconhecido'),
    };
  }
}
