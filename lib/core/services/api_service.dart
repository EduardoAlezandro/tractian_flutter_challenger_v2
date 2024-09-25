import 'package:dio/dio.dart';

class ApiService {
  final Dio dio;

  ApiService(this.dio) {
    dio.options.headers['Content-Type'] = 'application/json';
  }

  Future<dynamic> get(String url,
      {Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await dio.get(url, queryParameters: queryParameters);
      return _processResponse(response);
    } on DioError catch (e) {
      throw _handleError(e);
    }
  }

  Future<dynamic> post(String url, {dynamic data}) async {
    try {
      final response = await dio.post(url, data: data);
      return _processResponse(response);
    } on DioError catch (e) {
      throw _handleError(e);
    }
  }

  Future<dynamic> put(String url, {dynamic data}) async {
    try {
      final response = await dio.put(url, data: data);
      return _processResponse(response);
    } on DioError catch (e) {
      throw _handleError(e);
    }
  }

  Future<dynamic> delete(String url, {dynamic data}) async {
    try {
      final response = await dio.delete(url, data: data);
      return _processResponse(response);
    } on DioError catch (e) {
      throw _handleError(e);
    }
  }

  dynamic _processResponse(Response response) {
    if (response.statusCode! >= 200 && response.statusCode! < 300) {
      return response.data;
    } else {
      throw Exception('Erro na requisição: ${response.statusCode}');
    }
  }

  Exception _handleError(DioError error) {
    if (error.response != null) {
      return Exception(
          'Erro na resposta: ${error.response?.statusCode} - ${error.response?.statusMessage}');
    } else {
      return Exception('Erro na requisição: ${error.message}');
    }
  }
}
