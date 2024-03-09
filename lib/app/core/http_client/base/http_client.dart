import 'package:result_dart/result_dart.dart';

import 'http_client_exception.dart';
import 'http_client_response.dart';

/// Class that declares the necessary functions
/// for the app to work with http requests.
/// It relies on the Result pattern.
abstract class HttpClient {
  /// Executes GET http requests from a [String] path.
  /// As parameters, it allows a query parameters [Map]
  /// and a headers [Map].
  /// It relies on the Result pattern.
  AsyncResult<HttpClientResponse, HttpClientException> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  });
}
