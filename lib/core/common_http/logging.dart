import 'package:dio/dio.dart';

class LoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    print('Request: ${options.method} ${options.uri}');
    if (options.data != null) {
      print('Request Data: ${options.data}');
    }
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print('Response: ${response.statusCode} ${response.requestOptions.uri}');
    if (response.data != null) {
      print('Response Data: ${response.data}');
    }
    handler.next(response);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    print('Error: ${err.type} ${err.requestOptions.uri}');
    if (err.response != null) {
      print('Response Data: ${err.response?.data}');
    }
    handler.next(err);
  }
}