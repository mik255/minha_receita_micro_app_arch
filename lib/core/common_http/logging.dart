import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class LoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (kDebugMode) {
      print('Request: ${options.method} ${options.uri}');
    }
    if (options.data != null) {
      if (kDebugMode) {
        print('Request Data: ${options.data}');
      }
    }
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (kDebugMode) {
      print('Response: ${response.statusCode} ${response.requestOptions.uri}');
    }
    if (response.data != null) {
      if (kDebugMode) {
        print('Response Data: ${response.data}');
      }
    }
    handler.next(response);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    if (kDebugMode) {
      print('Error: ${err.type} ${err.requestOptions.uri}');
    }
    if (err.response != null) {
      if (kDebugMode) {
        print('Response Data: ${err.response?.data}');
      }
    }
    handler.next(err);
  }
}