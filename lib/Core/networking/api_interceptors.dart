import 'dart:async';
import 'package:dio/dio.dart';
import 'package:zikola_training_project/Core/networking/api_endpoints.dart';
import 'package:zikola_training_project/Core/routing/app_router.dart';
import 'package:zikola_training_project/Core/routing/app_routes.dart';
import 'package:zikola_training_project/Core/services/getit_service.dart';
import 'package:zikola_training_project/Core/services/secure_storage_service.dart';
import 'package:zikola_training_project/Core/services/shared_preferences_service.dart';

class ApiInterceptors extends Interceptor {
  final Dio dio;
  Completer<bool>? _refreshCompleter;

  ApiInterceptors(this.dio);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final secureStorage = getit<SecureStorageService>();
    final accessToken = await secureStorage.getAccessToken();
    if (accessToken != null) {
      options.headers['Authorization'] = 'Bearer $accessToken';
    }
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      if (_refreshCompleter != null) {
        // A refresh is already in progress, wait for it
        final success = await _refreshCompleter!.future;
        if (success) {
          // Retry this request
          final secureStorage = getit<SecureStorageService>();
          final accessToken = await secureStorage.getAccessToken();
          err.requestOptions.headers['Authorization'] = 'Bearer $accessToken';
          try {
            final response = await dio.fetch(err.requestOptions);
            return handler.resolve(response);
          } catch (e) {
            return handler.next(err);
          }
        } else {
          return handler.next(err);
        }
      }

      _refreshCompleter = Completer<bool>();
      
      final secureStorage = getit<SecureStorageService>();
      final refreshToken = await secureStorage.getRefreshToken();

      if (refreshToken == null) {
        _refreshCompleter!.complete(false);
        _refreshCompleter = null;
        _performLogout();
        return handler.next(err);
      }

      try {
        final refreshDio = Dio(BaseOptions(baseUrl: ApiEndpoints.baseUrl));
        final response = await refreshDio.post(
          ApiEndpoints.refreshToken,
          data: {'refreshToken': refreshToken},
        );

        final newAccessToken = response.data['access_token'];
        final newRefreshToken = response.data['refresh_token'];

        await secureStorage.saveTokens(
          accessToken: newAccessToken,
          refreshToken: newRefreshToken,
        );

        _refreshCompleter!.complete(true);
        _refreshCompleter = null;

        // Retry original request
        err.requestOptions.headers['Authorization'] = 'Bearer $newAccessToken';
        final retryResponse = await dio.fetch(err.requestOptions);
        return handler.resolve(retryResponse);

      } catch (e) {
        _refreshCompleter!.complete(false);
        _refreshCompleter = null;
        _performLogout();
        return handler.next(err);
      }
    }
    return super.onError(err, handler);
  }

  void _performLogout() {
    getit<SecureStorageService>().clearTokens();
    getit<SharedPreferencesService>().setLoggedIn(false);
    AppRouter.router.go(AppRoutes.kLoginRoute);
  }
}
