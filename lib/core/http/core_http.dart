import 'dart:io';

import 'core_response.dart';

abstract class CoreHttp {
  void addHeader(String key, String value);

  Future<CoreResponse> get({required String route, dynamic queryParameters});

  Future<CoreResponse> post({required String route, dynamic body,queryParameters});

  Future<CoreResponse> put({required String route, dynamic body,queryParameters});

  Future<CoreResponse> delete({required String route, dynamic body,queryParameters});

  Future<CoreResponse> multipartRequest({required String route, required List<File> files});
}
