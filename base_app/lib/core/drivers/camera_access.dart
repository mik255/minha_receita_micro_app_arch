import 'dart:io';

abstract class ICameraService {
  void requestPermission();

  Future<List<String>> getMultiImages({bool convertToBase64});

  Future<List<File>> pickVideos();
}
