import 'package:hive/hive.dart';
import 'package:zilant_look/common/AppData/data/data_sources/remote/app_data_api_service.dart';

import '../../../../data/models/photo_model.dart';

class MockAppDataApiService implements AppDataApiService {
  final Box<String> _humanPhotosBox;
  final Box<PhotoModel> _clothingItemsBox;

  MockAppDataApiService(this._humanPhotosBox, this._clothingItemsBox);

  @override
  Future<List<String>> getHumanPhotos() async {
    return _humanPhotosBox.values.toList();
  }

  @override
  Future<void> addHumanPhoto(String fileBase64, String userName) async {
    await _humanPhotosBox.add(fileBase64);
  }

  @override
  Future<List<PhotoModel>> getClothingItems() async {
    final items = _clothingItemsBox.values.toList();
    items.sort((a, b) {
      final categoryComparison = a.category.compareTo(b.category);
      if (categoryComparison != 0) return categoryComparison;
      return a.subcategory.compareTo(b.subcategory);
    });
    return items;
  }

  @override
  Future<void> addClothingItem(
    String fileBase64,
    String userName,
    String category,
    String subcategory,
    String subSubcategory,
  ) async {
    final newItem = PhotoModel(
      user_name: userName,
      image: fileBase64,
      category: category,
      subcategory: subcategory,
      sub_subcategory: subSubcategory,
    );
    await _clothingItemsBox.add(newItem);
  }

  @override
  Future<void> clearData() async {
    await _humanPhotosBox.clear();
    await _clothingItemsBox.clear();
  }

  Future<bool> hasUpdates() async {
    return false; // Нужно добавить логику для обновлений
  }
}
