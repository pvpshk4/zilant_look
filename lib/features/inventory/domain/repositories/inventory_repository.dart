import 'package:zilant_look/common/domain/entities/clothing_item_entity.dart';

abstract class InventoryRepository {
  Future<List<ClothingItemEntity>> getInventoryItems();
  Future<List<ClothingItemEntity>> filterInventoryByCategory(String category);
  Future<void> deleteClothingItem(String id);
  Future<void> addClothingItem(ClothingItemEntity item);
  Future<void> updateClothingItem(ClothingItemEntity item);
}
