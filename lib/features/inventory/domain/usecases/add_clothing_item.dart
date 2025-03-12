import 'package:zilant_look/common/domain/entities/clothing_item_entity.dart';
import 'package:zilant_look/features/inventory/domain/repositories/inventory_repository.dart';

class AddClothingItemUseCase {
  final InventoryRepository repository;

  AddClothingItemUseCase({required this.repository});

  Future<void> call(ClothingItemEntity item) async {
    return await repository.addClothingItem(item);
  }
}
