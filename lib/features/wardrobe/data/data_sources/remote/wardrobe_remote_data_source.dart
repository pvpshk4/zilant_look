// wardrobe_remote_data_source.dart
import 'package:zilant_look/common/data/models/clothing_item_model.dart';
import 'wardrobe_api_service.dart';

abstract class WardrobeRemoteDataSource {
  Future<List<ClothingItemModel>> getWardrobeItems({
    required int limit,
    required int offset,
  });

  Future<void> deleteClothingItem(String id);

  Future<void> updateClothingItem(ClothingItemModel item);
}

class WardrobeRemoteDataSourceImpl implements WardrobeRemoteDataSource {
  final WardrobeApiService _apiService;

  WardrobeRemoteDataSourceImpl(this._apiService);

  @override
  Future<List<ClothingItemModel>> getWardrobeItems({
    required int limit,
    required int offset,
  }) async {
    final response = await _apiService.getWardrobeItems(
      limit: limit,
      offset: offset,
    );
    return response.map((item) => ClothingItemModel.fromJson(item)).toList();
  }

  @override
  Future<void> deleteClothingItem(String id) async {
    await _apiService.deleteClothingItem(id);
  }

  @override
  Future<void> updateClothingItem(ClothingItemModel item) async {
    await _apiService.updateClothingItem(item.id, item.toJson());
  }
}
