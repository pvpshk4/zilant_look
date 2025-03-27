import 'package:zilant_look/common/domain/entities/clothing_item_entity.dart';

abstract class WardrobeRepository {
  Future<List<ClothingItemEntity>> getWardrobeItems({
    required int limit,
    required int offset,
  });

  Future<List<ClothingItemEntity>> filterWardrobeByCategory(String category);

  Future<void> deleteClothingItem(String id);

  Future<void> updateClothingItem(ClothingItemEntity item);
}
