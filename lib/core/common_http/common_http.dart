import 'package:dio/dio.dart';

import 'logging.dart';

class CommonHttp {
  static CommonHttp? instance;

  late Dio dio;
  void addHeader(String key, String value) {
    dio.options.headers[key] = value;
  }
  CommonHttp._internal({required String baseUrl}) {
    dio = Dio();
    dio.options.baseUrl = baseUrl;
    dio.interceptors.add(LoggingInterceptor());
  }

  factory CommonHttp({required String baseUrl}) {
    instance ??= CommonHttp._internal(baseUrl: baseUrl);
    return instance!;
  }

  Future<Response> get({required String route}) async {
    var response = dio.get(
      route,
    );
    return response;
  }

  Future<Response> post({required String route, dynamic body}) async {
    var response = dio.post(
      route,
      data: body,
    );
    return response;
  }
}
