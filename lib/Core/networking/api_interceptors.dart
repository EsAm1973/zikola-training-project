import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:zikola_training_project/Core/networking/api_endpoints.dart';
import 'package:zikola_training_project/Core/services/getit_service.dart';
import 'package:zikola_training_project/Core/services/secure_storage_service.dart';
import 'package:zikola_training_project/Core/services/shared_preferences_service.dart';

class ApiInterceptors extends Interceptor {
  final Dio dio;
  static Completer<bool>? _refreshCompleter;

  ApiInterceptors(this.dio);

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final secureStorage = getit<SecureStorageService>();
    final accessToken = await secureStorage.getAccessToken();
    if (accessToken != null) {
      options.headers['Authorization'] = 'Bearer $accessToken';
    }
    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    //debugPrint('❌ Error Status Code: ${err.response?.statusCode}');

    if (err.response?.statusCode == 401) {
      //debugPrint('🔄 Access token expired -> starting refresh flow');

      // if (_refreshCompleter != null) {
      //   debugPrint('⏳ Waiting for existing refresh request...');
      // }

      if (_refreshCompleter != null) {
        final success = await _refreshCompleter!.future;

        //debugPrint('✅ Existing refresh completed: $success');

        if (success) {
          final secureStorage = getit<SecureStorageService>();
          final accessToken = await secureStorage.getAccessToken();

          //debugPrint('🚀 Retrying original request...');

          err.requestOptions.headers['Authorization'] = 'Bearer $accessToken';

          try {
            final response = await dio.fetch(err.requestOptions);

            //debugPrint('✅ Retried request success');

            return handler.resolve(response);
          } catch (e) {
            //debugPrint('❌ Retried request failed: $e');
            return handler.next(err);
          }
        } else {
          //debugPrint('❌ Refresh failed');
          return handler.next(err);
        }
      }

      _refreshCompleter = Completer<bool>();

      final secureStorage = getit<SecureStorageService>();
      final refreshToken = await secureStorage.getRefreshToken();

      debugPrint('📌 Refresh Token: $refreshToken');

      if (refreshToken == null) {
        debugPrint('❌ No refresh token found');

        _refreshCompleter!.complete(false);
        _refreshCompleter = null;
        await _performLogout();

        return handler.next(err);
      }

      try {
        //debugPrint('📡 Calling refresh endpoint...');

        final refreshDio = Dio(BaseOptions(baseUrl: ApiEndpoints.baseUrl));

        final response = await refreshDio.post(
          ApiEndpoints.refreshToken,
          data: {'refreshToken': refreshToken},
        );

        //debugPrint('✅ Refresh response: ${response.data}');

        final newAccessToken = response.data['access_token'] as String?;

        final newRefreshToken = response.data['refresh_token'] as String?;

        await secureStorage.saveTokens(
          accessToken: newAccessToken!,
          refreshToken: newRefreshToken!,
        );

        //debugPrint('💾 New tokens saved successfully');

        _refreshCompleter!.complete(true);
        _refreshCompleter = null;

        err.requestOptions.headers['Authorization'] = 'Bearer $newAccessToken';

        //debugPrint('🚀 Retrying original request after refresh');

        final retryResponse = await dio.fetch(err.requestOptions);

        //debugPrint('✅ Final request success');

        return handler.resolve(retryResponse);
      } catch (e) {
        //debugPrint('❌ Refresh process failed: $e');

        _refreshCompleter!.complete(false);
        _refreshCompleter = null;
        await _performLogout();

        return handler.next(err);
      }
    }

    return super.onError(err, handler);
  }

  Future<void> _performLogout() async {
    await getit<SecureStorageService>().clearTokens();
    await getit<SharedPreferencesService>().clearAuthData();
    AuthEventBus.instance.addEvent(AuthEvent.logout);
  }
}

enum AuthEvent { logout }

class AuthEventBus {
  AuthEventBus._();
  static final AuthEventBus instance = AuthEventBus._();

  final _controller = StreamController<AuthEvent>.broadcast();

  Stream<AuthEvent> get stream => _controller.stream;

  void addEvent(AuthEvent event) {
    if (!_controller.isClosed) {
      _controller.add(event);
    }
  }

  void dispose() => _controller.close();
}
