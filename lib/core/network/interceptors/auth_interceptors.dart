// lib/core/network/interceptors/auth_interceptor.dart
import 'package:dio/dio.dart';
import '../../utils/storage_helper.dart';

/// Interceptor لإضافة Token للـ API Requests
/// Automatically adds authentication token to all requests
class AuthInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    // Get token from storage
    final token = await StorageHelper.getToken();
    
    // Add token to headers if exists
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    
    return handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // Handle 401 Unauthorized - Logout user
    if (err.response?.statusCode == 401) {
      // TODO: Implement logout logic
      // ref.read(authNotifierProvider.notifier).logout();
    }
    
    return handler.next(err);
  }
}

