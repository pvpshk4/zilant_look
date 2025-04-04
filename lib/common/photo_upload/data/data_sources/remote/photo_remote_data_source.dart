import 'dart:io';
import 'package:zilant_look/common/photo_upload/data/data_sources/remote/photo_api_service.dart';
import 'package:zilant_look/common/photo_upload/data/models/photo_model.dart';
import 'package:dio/dio.dart';
import 'dart:convert';

abstract class PhotoRemoteDataSource {
  Future<PhotoModel> uploadClothesPhoto(
    File file,
    String username,
    String category,
    String subcategory,
    String sub_subcategory,
  );

  Future<PhotoModel> uploadHumanPhoto(File file, String username);
}

class PhotoRemoteDataSourceImpl implements PhotoRemoteDataSource {
  final PhotoApiService _apiService;

  PhotoRemoteDataSourceImpl({required Dio dio})
    : _apiService = PhotoApiService(dio);

  @override
  Future<PhotoModel> uploadClothesPhoto(
    File file,
    String username,
    String category,
    String subcategory,
    String sub_subcategory,
  ) async {
    try {
      final bytes = await file.readAsBytes();
      final base64Image = base64Encode(bytes);

      // Формируем корректный JSON
      final requestData = {
        "user_name": username,
        "image": base64Image,
        "category": category,
        "subcategory": subcategory,
        "sub_subcategory": sub_subcategory,
      };

      // Отправляем как JSON
      return await _apiService.uploadClothesPhoto(requestData);
    } catch (e) {
      throw Exception('Failed to upload clothes photo: $e');
    }
  }

  @override
  Future<PhotoModel> uploadHumanPhoto(File file, String username) async {
    try {
      final bytes = await file.readAsBytes();
      final base64Image = base64Encode(bytes);

      // Формируем корректный JSON
      final requestData = {"user_name": username, "image": base64Image};

      // Отправляем как JSON
      return await _apiService.uploadHumanPhoto(requestData);
    } catch (e) {
      throw Exception('Failed to upload human photo: $e');
    }
  }
}
