import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import '../../shared/services/api_service.dart';
import '../../shared/services/auth_service.dart';
import '../../shared/services/storage_service.dart';

final GetIt getIt = GetIt.instance;

Future<void> configureDependencies() async {
  // Services
  getIt.registerLazySingleton<StorageService>(() => StorageService());
  getIt.registerLazySingleton<ApiService>(() => ApiService());
  getIt.registerLazySingleton<AuthService>(() => AuthService());
  
  // Dio
  getIt.registerLazySingleton<Dio>(() {
    final dio = Dio(BaseOptions(
      baseUrl: 'https://vcare.integration25.com/api',
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
    ));
    
    // Add interceptors
    dio.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
      logPrint: (obj) => print(obj),
    ));
    
    return dio;
  });
}