import 'dart:async';
import 'package:dio/dio.dart';
import 'package:zikola_training_project/Core/networking/api_endpoints.dart';
import 'package:zikola_training_project/Core/services/getit_service.dart';
import 'package:zikola_training_project/Core/services/secure_storage_service.dart';
import 'package:zikola_training_project/Core/services/shared_preferences_service.dart';

class ApiInterceptors extends Interceptor {
  final Dio dio;

  // ✅ static عشان نضمن إن في refresh واحد بس في أي وقت
  // حتى لو في أكتر من instance من الـ interceptor
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
    if (err.response?.statusCode == 401) {
      if (_refreshCompleter != null) {
        // Refresh شغال بالفعل، استنى النتيجة
        final success = await _refreshCompleter!.future;
        if (success) {
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

        // ✅ Null safety: نتأكد من الـ tokens قبل ما نحفظهم
        final newAccessToken = response.data['access_token'] as String?;
        final newRefreshToken = response.data['refresh_token'] as String?;

        if (newAccessToken == null || newRefreshToken == null) {
          _refreshCompleter!.complete(false);
          _refreshCompleter = null;
          _performLogout();
          return handler.next(err);
        }

        await secureStorage.saveTokens(
          accessToken: newAccessToken,
          refreshToken: newRefreshToken,
        );

        _refreshCompleter!.complete(true);
        _refreshCompleter = null;

        // Retry الـ request الأصلي
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

  /// ✅ بدل Navigation مباشرة، بنستخدم Stream عشان نفصل
  /// الـ interceptor عن الـ UI layer
  void _performLogout() {
    getit<SecureStorageService>().clearTokens();
    getit<SharedPreferencesService>().clearAuthData();
    // ✅ نطلق event عبر stream بدل ما نعمل navigation مباشرة
    AuthEventBus.instance.addEvent(AuthEvent.logout);
  }
}

/// Stream-based event bus للـ auth events
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
