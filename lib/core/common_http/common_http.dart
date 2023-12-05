import 'package:dio/dio.dart';

import 'logging.dart';

class CommonHttp {
  static CommonHttp? instance;

  late Dio dio;

  CommonHttp._internal() {
    dio = Dio();
    dio.interceptors.add(LoggingInterceptor());
  }

  factory CommonHttp() {
    instance ??= CommonHttp._internal();
    return instance!;
  }

  Future<Response> get({required String url}) async {
    var response =  dio.get(url);
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
