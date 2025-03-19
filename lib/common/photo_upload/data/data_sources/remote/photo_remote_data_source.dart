import 'dart:io';
import 'package:zilant_look/common/photo_upload/data/data_sources/remote/photo_api_service.dart';
import 'package:zilant_look/common/photo_upload/data/models/photo_model.dart';
import 'package:dio/dio.dart';

abstract class PhotoRemoteDataSource {
  Future<PhotoModel> uploadPhoto(File file);
  Future<PhotoModel> getPhoto(String photoId);
}

class PhotoRemoteDataSourceImpl implements PhotoRemoteDataSource {
  final PhotoApiService _apiService;

  PhotoRemoteDataSourceImpl({required Dio dio})
    : _apiService = PhotoApiService(dio);

  @override
  Future<PhotoModel> uploadPhoto(File file) async {
    try {
      return await _apiService.uploadPhoto(file);
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
