import 'package:dio/dio.dart';
import 'session.dart';

class ApiClient {
  ApiClient._internal()
      : _dio = Dio(
          BaseOptions(
            baseUrl: const String.fromEnvironment('API_BASE', defaultValue: 'http://localhost:5050/api'),
            connectTimeout: const Duration(seconds: 10),
            receiveTimeout: const Duration(seconds: 20),
            headers: { 'Accept': 'application/json' },
          ),
        ) {
    _dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) async {
      final token = await SessionManager.instance.getToken();
      if (token != null) {
        options.headers['Authorization'] = 'Bearer $token';
      }
      handler.next(options);
    }));
  }

  static final ApiClient instance = ApiClient._internal();
  final Dio _dio;

  Dio get dio => _dio;
}

