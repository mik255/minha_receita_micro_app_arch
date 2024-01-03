import 'dart:io';
import 'package:micro_app_core/micro_app_core.dart';

class ServerFileService implements FileServiceInterface {
  final CoreHttp http;

  ServerFileService(this.http);

  @override
  Future<List<String>> upload(List<File> files) async {
    var response =
        await http.multipartRequest(route: '/files/upload', files: files);
    return (response.data as List<dynamic>)
        .map((e) => e['url'] as String)
        .toList();
  }

  @override
  Future<void> delete(String imageUrl) {
    // TODO: implement delete
    throw UnimplementedError();
  }
}
