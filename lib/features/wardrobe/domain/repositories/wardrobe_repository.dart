import 'package:zilant_look/common/domain/entities/clothing_item_entity.dart';

abstract class WardrobeRepository {
  Future<List<ClothingItemEntity>> getWardrobeItems();
  Future<List<ClothingItemEntity>> filterWardrobeByCategory(String category);
  Future<void> deleteClothingItem(String id);
  Future<void> addClothingItem(ClothingItemEntity item);
  Future<void> updateClothingItem(ClothingItemEntity item);
}
