import 'package:result_dart/result_dart.dart';

import 'http_client_exception.dart';
import 'http_client_response.dart';

abstract class HttpClient {
  AsyncResult<HttpClientResponse, HttpClientException> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  });
}
