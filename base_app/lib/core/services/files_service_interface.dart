import 'dart:io';

abstract class FileServiceInterface {
  Future<List<String>> upload(List<File> image);
  Future<void> delete(String imageUrl);
}
