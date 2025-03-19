import 'package:zilant_look/common/domain/entities/clothing_item_entity.dart';
import 'package:zilant_look/features/inventory/data/repositories/inventory_repository_impl.dart';

class UpdateClothingItemUseCase {
  final InventoryRepositoryImpl _inventoryRepositoryImpl;

  UpdateClothingItemUseCase(this._inventoryRepositoryImpl);

  Future<void> call(ClothingItemEntity item) async {
    return await _inventoryRepositoryImpl.updateClothingItem(item);
  }
}
