import 'package:dio/dio.dart';

class ApiInterceptors extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // You can add headers, log requests, or modify the request here
    options.headers['token'] = 'Bearer YOUR_ACCESS_TOKEN';
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // You can log responses or modify the response here
    print('Response: ${response.statusCode} ${response.requestOptions.path}');
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // You can log errors or handle specific error cases here
    print('Error: ${err.message} ${err.requestOptions.path}');
    super.onError(err, handler);
  }
}
