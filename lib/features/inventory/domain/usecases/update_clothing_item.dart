import 'package:zilant_look/common/domain/entities/clothing_item_entity.dart';
import 'package:zilant_look/features/inventory/domain/repositories/inventory_repository.dart';

class UpdateClothingItemUseCase {
  final InventoryRepository repository;

  UpdateClothingItemUseCase({required this.repository});

  Future<void> call(ClothingItemEntity item) async {
    return await repository.updateClothingItem(item);
  }
}
