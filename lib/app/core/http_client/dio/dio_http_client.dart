import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:result_dart/result_dart.dart';

import '../base/http_client.dart';
import '../base/http_client_exception.dart';
import '../base/http_client_response.dart';

class DioHttpClient implements HttpClient {
  final Dio _dio;

  const DioHttpClient(this._dio);

  @override
  AsyncResult<HttpClientResponse, HttpClientException> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    HttpClientResponse? response;
    try {
      final result = await _dio.get(
        path,
        options: Options(headers: headers),
        queryParameters: queryParameters,
      );
      response = HttpClientResponse(result.data, result.statusCode ?? -1, result.statusMessage ?? '');
      log(
        '✅ Method: GET\nClient: Dio\n'
        'Path ${result.requestOptions.path}\n'
        'Headers: ${result.requestOptions.headers.toString()}\n'
        'Query Params: ${result.requestOptions.queryParameters}',
        name: 'HttpClient',
      );
      return Result.success(response);
    } on DioException catch (e) {
      log(
        '🔴 Method: GET\nClient: Dio\n'
        'Path ${e.requestOptions.path}\n'
        'Headers: ${e.requestOptions.headers.toString()}\n'
        'Query Params: ${e.requestOptions.queryParameters}\n'
        'Data: ${e.response?.data}\n'
        'Status Message: ${e.response?.statusMessage}\n'
        'Message: ${e.message}\n'
        'Status Code: ${e.response?.statusCode}',
        name: 'HttpClient',
      );
      return Result.failure(
        HttpClientException(
          e.message ?? '',
          e.stackTrace,
          e.response?.statusCode ?? 404,
        ),
      );
    }
  }

  @override
  AsyncResult<HttpClientResponse, HttpClientException> post(
    String path, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    Object? data,
  }) async {
    HttpClientResponse? response;
    try {
      final result = await _dio.post(
        path,
        options: headers != null ? Options(headers: headers) : null,
        queryParameters: queryParameters,
        data: data,
      );
      response = HttpClientResponse(result.data, result.statusCode ?? -1, result.statusMessage ?? '');
      log(
        '✅ Method: POST\nClient: Dio\n'
        'Path ${result.requestOptions.path}\n'
        'Headers: ${result.requestOptions.headers.toString()}\n'
        'Query Params: ${result.requestOptions.queryParameters}',
        name: 'HttpClient',
      );
      return Result.success(response);
    } on DioException catch (e) {
      log(
        '🔴 Method: POST\nClient: Dio\n'
        'Path ${e.requestOptions.path}\n'
        'Headers: ${e.requestOptions.headers.toString()}\n'
        'Query Params: ${e.requestOptions.queryParameters}\n'
        'Data: ${e.response?.data}\n'
        'Status Message: ${e.response?.statusMessage}\n'
        'Message: ${e.message}\n'
        'Status Code: ${e.response?.statusCode}',
        name: 'HttpClient',
      );
      return Result.failure(
        HttpClientException(
          e.message ?? '',
          e.stackTrace,
          e.response?.statusCode ?? 404,
        ),
      );
    }
  }
}
