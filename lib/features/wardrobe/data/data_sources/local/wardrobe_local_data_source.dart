import 'package:hive/hive.dart';
import 'package:zilant_look/common/data/models/clothing_item_model.dart';

abstract class WardrobeLocalDataSource {
  Future<void> cacheWardrobeItems(List<ClothingItemModel> items);
  Future<List<ClothingItemModel>> getCachedWardrobeItems();
  Future<void> clearCache();
}

class WardrobeLocalDataSourceImpl implements WardrobeLocalDataSource {
  final Box<ClothingItemModel> _wardrobeBox;

  WardrobeLocalDataSourceImpl(this._wardrobeBox);

  @override
  Future<void> cacheWardrobeItems(List<ClothingItemModel> items) async {
    await _wardrobeBox.clear();
    await _wardrobeBox.addAll(items);
  }

  @override
  Future<List<ClothingItemModel>> getCachedWardrobeItems() async {
    return _wardrobeBox.values.toList();
  }

  @override
  Future<void> clearCache() async {
    await _wardrobeBox.clear();
  }
}
