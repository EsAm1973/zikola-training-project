import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:zikola_training_project/Core/errors/failure.dart';
import 'package:zikola_training_project/Core/networking/api_consumer.dart';
import 'package:zikola_training_project/Core/networking/api_endpoints.dart';
import 'package:zikola_training_project/Core/networking/api_interceptors.dart';

class DioConsumer implements ApiConsumer {
  final Dio dio;

  DioConsumer({required this.dio}) {
    dio.options.baseUrl = ApiEndpoints.baseUrl;
    dio.interceptors.add(ApiInterceptors(dio));
    dio.interceptors.add(
      PrettyDioLogger(
        request: true,
        requestBody: true,
        responseBody: true,
        responseHeader: true,
        error: true,
      ),
    );
  }
  @override
  Future<dynamic> post(
    String path, {
    Map<String, dynamic>? queryParameters,
    Object? data,
    bool isFormData = false,
  }) async {
    try {
      final response = await dio.post(
        path,
        queryParameters: queryParameters,
        data: isFormData
            ? FormData.fromMap(data as Map<String, dynamic>)
            : data,
      );
      return response.data;
    } on DioException catch (e) {
      throw ServerFailure.fromDioException(e);
    } catch (e) {
      throw ServerFailure(errorMessage: 'Unexpected error: $e');
    }
  }

  @override
  Future<dynamic> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Object? data,
    bool isFormData = false,
  }) async {
    try {
      final response = await dio.get(
        path,
        queryParameters: queryParameters,
        data: isFormData
            ? FormData.fromMap(data as Map<String, dynamic>)
            : data,
      );
      return response.data;
    } on DioException catch (e) {
      throw ServerFailure.fromDioException(e);
    } catch (e) {
      throw ServerFailure(errorMessage: 'Unexpected error: $e');
    }
  }

  @override
  Future<dynamic> patch(
    String path, {
    Map<String, dynamic>? queryParameters,
    Object? data,
    bool isFormData = false,
  }) async {
    try {
      final response = await dio.patch(
        path,
        queryParameters: queryParameters,
        data: isFormData
            ? FormData.fromMap(data as Map<String, dynamic>)
            : data,
      );
      return response.data;
    } on DioException catch (e) {
      throw ServerFailure.fromDioException(e);
    } catch (e) {
      throw ServerFailure(errorMessage: 'Unexpected error: $e');
    }
  }

  @override
  Future<dynamic> delete(String path, {bool isFormData = false}) async {
    try {
      final response = await dio.delete(
        path,
        data: isFormData
            ? FormData.fromMap(
                {},
              ) // Assuming you want to send an empty FormData when isFormData is true
            : null,
      );
      return response.data;
    } on DioException catch (e) {
      throw ServerFailure.fromDioException(e);
    } catch (e) {
      throw ServerFailure(errorMessage: 'Unexpected error: $e');
    }
  }
}
