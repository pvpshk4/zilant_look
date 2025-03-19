import 'package:zilant_look/common/domain/entities/clothing_item_entity.dart';
import 'package:zilant_look/features/inventory/data/repositories/inventory_repository_impl.dart';

class FilterInventoryByCategoryUseCase {
  final InventoryRepositoryImpl _inventoryRepositoryImpl;

  FilterInventoryByCategoryUseCase(this._inventoryRepositoryImpl);

  Future<List<ClothingItemEntity>> call(String category) async {
    return await _inventoryRepositoryImpl.filterInventoryByCategory(category);
  }
}
