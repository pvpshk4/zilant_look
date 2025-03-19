import 'package:zilant_look/common/domain/entities/clothing_item_entity.dart';
import 'package:zilant_look/features/inventory/data/repositories/inventory_repository_impl.dart';

class GetInventoryItemsUseCase {
  final InventoryRepositoryImpl _inventoryRepositoryImpl;

  GetInventoryItemsUseCase(this._inventoryRepositoryImpl);

  Future<List<ClothingItemEntity>> call() async {
    return await _inventoryRepositoryImpl.getInventoryItems();
  }
}
