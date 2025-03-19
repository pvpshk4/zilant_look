import 'package:zilant_look/features/inventory/data/repositories/inventory_repository_impl.dart';

class DeleteClothingItemUseCase {
  final InventoryRepositoryImpl _inventoryRepositoryImpl;

  DeleteClothingItemUseCase(this._inventoryRepositoryImpl);

  Future<void> call(String id) async {
    return await _inventoryRepositoryImpl.deleteClothingItem(id);
  }
}
