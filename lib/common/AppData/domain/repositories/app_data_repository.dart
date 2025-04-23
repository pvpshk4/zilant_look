import 'package:zilant_look/common/data/models/photo_model.dart';

import '../../data/data_sources/remote/app_data_api_service.dart';

class AppDataRepository {
  final AppDataApiService _apiService;

  AppDataRepository(this._apiService);

  Future<List<String>> getHumanPhotos() async {
    return await _apiService.getHumanPhotos();
  }

  Future<List<PhotoModel>> getClothingItems() async {
    return await _apiService.getClothingItems();
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
}
