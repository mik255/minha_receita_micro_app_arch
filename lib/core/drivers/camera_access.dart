import 'dart:io';

abstract class DeviceDataAccess {
  void requestPermission();

  Future<List<String>> getMultiImages();

  Future<List<File>> pickVideos();
}
