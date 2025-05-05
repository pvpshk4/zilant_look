import 'package:zilant_look/common/AppData/data/models/deleted_photo_model.dart';
import 'package:zilant_look/common/AppData/data/models/photo_model.dart';
import '../../data/data_sources/remote/app_data_api_service.dart';
import '../../data/data_sources/remote/mock_app_data_api_service.dart';

class AppDataRepository {
  final AppDataApiService _apiService;

  AppDataRepository(this._apiService);

  Future<List<String>> getHumanPhotos() async {
    return await _apiService.getHumanPhotos();
  }

  Future<List<PhotoModel>> getCatalogItems() async {
    return await _apiService.getCatalogItems();
  }

  Future<List<PhotoModel>> getWardrobeItems() async {
    return await _apiService.getWardrobeItems();
  }

  Future<void> addHumanPhoto(String fileBase64, String userName) async {
    await _apiService.addHumanPhoto(fileBase64, userName);
  }

  Future<void> addClothingItem(
    String fileBase64,
    String userName,
    String category,
    String subcategory,
    String subSubcategory,
  ) async {
    await _apiService.addClothingItem(
      fileBase64,
      userName,
      category,
      subcategory,
      subSubcategory,
    );
  }

  Future<void> clearData() async {
    await _apiService.clearData();
  }

  Future<void> deletePhoto(String id, String type) async {
    await _apiService.deletePhoto(id, type);
  }

  Future<List<DeletedPhotoModel>> getDeletedPhotos() async {
    if (_apiService is MockAppDataApiService) {
      return await (_apiService).getDeletedPhotos();
    }
    throw UnimplementedError(
      'getDeletedPhotos is only available in MockAppDataApiService',
    );
  }

  Future<void> permanentlyDeletePhoto(String imageBase64) async {
    if (_apiService is MockAppDataApiService) {
      await (_apiService).permanentlyDeletePhoto(imageBase64);
    } else {
      throw UnimplementedError(
        'permanentlyDeletePhoto is only available in MockAppDataApiService',
      );
    }
  }
}
