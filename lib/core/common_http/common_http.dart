import 'package:dio/dio.dart';

import 'logging.dart';

class CommonHttp {
  static CommonHttp? instance;

  late Dio dio;

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
    var response =  dio.get(
      route,
    );
    return response;
  }

  Future<Response> post({required String url, dynamic data}) async {
    try {
      return await dio.post(
        url,
        data: data,
      );
    } catch (e) {
      rethrow;
    }
  }
}
