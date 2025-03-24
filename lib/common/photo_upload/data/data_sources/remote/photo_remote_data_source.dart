import 'dart:io';
import 'package:zilant_look/common/photo_upload/data/data_sources/remote/photo_api_service.dart';
import 'package:zilant_look/common/photo_upload/data/models/photo_model.dart';
import 'package:dio/dio.dart';
import 'dart:convert'; // Для работы с base64

abstract class PhotoRemoteDataSource {
  Future<PhotoModel> uploadPhoto(File file, String username);
  Future<PhotoModel> getPhoto(String photoId);
}

class PhotoRemoteDataSourceImpl implements PhotoRemoteDataSource {
  final PhotoApiService _apiService;

  PhotoRemoteDataSourceImpl({required Dio dio})
    : _apiService = PhotoApiService(dio);

  @override
  Future<PhotoModel> uploadPhoto(File file, String username) async {
    try {
      // Преобразуем файл в base64
      final bytes = await file.readAsBytes();
      final base64Image = base64Encode(bytes);

      // Отправляем данные на сервер
      return await _apiService.uploadPhoto(
        username: username,
        photoBase64: base64Image,
      );
    } catch (e) {
      throw Exception('Failed to upload photo: $e');
    }
  }

  @override
  Future<PhotoModel> getPhoto(String photoId) async {
    try {
      return await _apiService.getPhoto(photoId);
    } catch (e) {
      throw Exception('Failed to load photo: $e');
    }
  }
}
