import 'dart:io';

import 'package:minha_receita/core/http/core_http.dart';

import '../../../core/services/files_service_interface.dart';

class ServerFileService implements FileServiceInterface {

  final CoreHttp http;
  ServerFileService(this.http);

  @override
  Future<List<String>> upload(List<File> files) async {
    var response = await http.multipartRequest(route: '/files/upload', files: files);
    return (response.data as List<dynamic>).map((e) => e['url'] as String).toList();
  }

  @override
  Future<void> delete(String imageUrl) {
    // TODO: implement delete
    throw UnimplementedError();
  }

}
