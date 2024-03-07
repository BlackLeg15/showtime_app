class HttpClientException {
  final String message;
  final StackTrace stackTrace;
  final int statusCode;

  HttpClientException(this.message, this.stackTrace, this.statusCode);
}
