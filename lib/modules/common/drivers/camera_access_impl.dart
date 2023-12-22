import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:video_compress/video_compress.dart';

import '../../../core/drivers/camera_access.dart';

class CameraAccessImpl implements DeviceDataAccess {
  @override
  Future<List<String>> getMultiImages() async {
    await requestPermission();
    List<Asset> resultList = [];
    List<String> base64Images = [];
    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 5,
        enableCamera: true,
      );
    } on Exception catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
    for (var image in resultList) {
      final ByteData byteData = await image.getByteData();
      final List<int> imageData = byteData.buffer.asUint8List();
      final String base64Image = base64Encode(imageData);
      base64Images.add(base64Image);
    }
    return base64Images;
  }

  @override
  Future<List<File>> pickVideos() async {
    try {
      // Solicitar permissão antes de acessar a galeria
      await requestPermission();

      // Permitir que o usuário selecione vídeos da galeria
      List<XFile>? pickedFiles = await ImagePicker().pickMultipleMedia();

      if (pickedFiles.isNotEmpty) {
        // Converter XFile para File
        List<File> selectedVideos = pickedFiles.map((file) => File(file.path)).toList();
        var convertedVideos = await Future.wait(selectedVideos.map((video) => converterPara720p(video.path)));
        return convertedVideos;
      } else {
        // O usuário cancelou a seleção
        return [];
      }
    } catch (error) {
      // Tratar erros, por exemplo, permissões negadas
      if (kDebugMode) {
        print('Erro ao selecionar vídeos: $error');
      }
      return [];
    }
  }
  Future<File> converterPara720p(String caminhoDoVideo) async {
    try {
      final result = await VideoCompress.compressVideo(
        caminhoDoVideo,
        quality: VideoQuality.Res640x480Quality, // Pode ajustar conforme necessário
        deleteOrigin: true,
        includeAudio: true,
      );
      return result!.file!;
    } catch (error) {
      if (kDebugMode) {
        print('Erro ao converter o vídeo: $error');
      }
      rethrow;
    }
  }
  @override
  Future<void> requestPermission() async {
    List<bool> status = await Future.wait([
      Permission.videos.status.isGranted,
      Permission.photos.status.isGranted,
    ]);

    bool isGranted = status.every((element) => element == true);

    if (!isGranted) {
      await Permission.videos.request();
      await Permission.photos.request();
    }
  }
}
