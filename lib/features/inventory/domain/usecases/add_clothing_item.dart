import 'package:zilant_look/common/domain/entities/clothing_item_entity.dart';
import 'package:zilant_look/features/inventory/data/repositories/inventory_repository_impl.dart';

class AddClothingItemUseCase {
  final InventoryRepositoryImpl _inventoryRepositoryImpl;

  AddClothingItemUseCase(this._inventoryRepositoryImpl);

  Future<void> call(ClothingItemEntity item) async {
    return await _inventoryRepositoryImpl.addClothingItem(item);
  }
}
