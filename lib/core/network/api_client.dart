import 'package:dio/dio.dart' as dio;
import '../constants/api_constants.dart';

class ApiClient {
  final dio.Dio _dio;
  
  ApiClient() : _dio = dio.Dio() {
    _dio.options.baseUrl = ApiConstants.baseUrl;
    _dio.options.connectTimeout = const Duration(seconds: 15);
    _dio.options.receiveTimeout = const Duration(seconds: 15);
    _dio.options.queryParameters = {'api_key': ApiConstants.apiKey};
    
    // Add interceptors for logging, error handling, etc.
    _dio.interceptors.add(dio.LogInterceptor(
      request: true,
      requestHeader: true,
      requestBody: true,
      responseHeader: true,
      responseBody: true,
      error: true,
    ));
  }
  
  /// Performs a GET request to the specified [path] with the given [queryParameters].
  ///
  /// If the request is successful, the response is returned. If the request fails,
  /// a [DioException] is thrown. This exception is caught and handled by
  /// [_handleError].
  ///
  /// Returns a [dio.Response] object containing the response data, headers, and status code.
  Future<dio.Response> get(String path, {Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await _dio.get(
        path,
        queryParameters: queryParameters,
      );
      return response;
    } on dio.DioException catch (e) {
      return _handleError(e);
    }
  }
  
  Future<dio.Response> post(String path, {dynamic data, Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await _dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
      );
      return response;
    } on dio.DioException catch (e) {
      return _handleError(e);
    }
  }
  
  dio.Response _handleError(dio.DioException error) {
    if (error.type == dio.DioExceptionType.connectionTimeout ||
        error.type == dio.DioExceptionType.receiveTimeout ||
        error.type == dio.DioExceptionType.sendTimeout) {
      throw TimeoutException();
    } else if (error.type == dio.DioExceptionType.connectionError) {
      throw NetworkException();
    } else {
      throw ServerException(error.response?.statusCode ?? 500);
    }
  }
}

class TimeoutException implements Exception {
  final String message = 'Connection timeout. Please try again.';
}

class NetworkException implements Exception {
  final String message = 'No internet connection. Please check your network.';
}

class ServerException implements Exception {
  final int statusCode;
  String get message => 'Server error: $statusCode';
  
  ServerException(this.statusCode);
}
