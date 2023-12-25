import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../../../core/http/core_http.dart';

import '../domian/models/common_response.dart';

class CommonHttp implements CoreHttp {
  late Dio dio;

  @override
  void addHeader(String key, String value) {
    dio.options.headers[key] = value;
  }

  CommonHttp({required String baseUrl}) {
    dio = Dio();
    dio.options.baseUrl = baseUrl;
    final logInterceptor = PrettyDioLogger(
      requestBody: true,
      requestHeader: true,
    );

    dio.interceptors.add(logInterceptor);
    //add cors
    //   dio.options.headers['Access-Control-Allow-Origin'] = '*';
    //   dio.options.headers['Access-Control-Allow-Methods'] = 'GET, POST, PUT, DELETE, OPTIONS';
    //   dio.options.headers['Access-Control-Allow-Headers'] = 'Origin, Content-Type, X-Auth-Token';
  }

  @override
  Future<CommonResponse> get(
      {required String route, dynamic queryParameters}) async {
    var response = await dio.get(
      route,
      queryParameters: queryParameters,
    );
    return CommonResponse(
      statusCode: response.statusCode,
      data: response.data,
      headers: dio.options.headers,
    );
  }

  @override
  Future<CommonResponse> post(
      {required String route, dynamic body, queryParameters}) async {
    var response = await dio.post(
      route,
      data: body,
    );
    return CommonResponse(
      statusCode: response.statusCode,
      data: response.data,
      headers: dio.options.headers,
    );
  }

  @override
  Future<CommonResponse> delete(
      {required String route, body, queryParameters}) async {
    var response = await dio.delete(
      route,
      data: body,
      queryParameters: queryParameters,
    );
    return CommonResponse(
      statusCode: response.statusCode,
      data: response.data,
      headers: dio.options.headers,
    );
  }

  @override
  Future<CommonResponse> put(
      {required String route, body, queryParameters}) async {
    var response = await dio.post(
      route,
      data: body,
    );
    return CommonResponse(
      statusCode: response.statusCode,
      data: response.data,
      headers: dio.options.headers,
    );
  }

  @override
  Future<CommonResponse> multipartRequest(
      {required String route, required List<File> files}) async {
    try {
      var filesData = Future.wait(
        files.map(
          (file) async {
            return await MultipartFile.fromFile(
              file.path,
              filename: file.path.split('/').last,
            );
          },
        ),
      );
      FormData formData = FormData.fromMap({
        'files': await filesData,
        // Adicione outros parâmetros aqui, se necessário
      });

      // Faça a requisição usando postFormData
      var response = await dio.post(
        route,
        data: formData,
        options: Options(
          headers: {
            ...dio.options.headers,
            'Content-Type': 'multipart/form-data',
          },
        ),
      );

      return CommonResponse(
        statusCode: response.statusCode,
        data: response.data,
        headers: dio.options.headers,
      );
    } catch (error) {
      // Trate os erros aqui
      if (kDebugMode) {
        print('Erro na requisição multipart: $error');
      }
      return CommonResponse(
        statusCode: -1, // Defina um código de status adequado para erros
        data: null,
        headers: dio.options.headers,
      );
    }
  }
}
