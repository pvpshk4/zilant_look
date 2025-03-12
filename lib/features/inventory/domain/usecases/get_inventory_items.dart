import 'package:zilant_look/common/domain/entities/clothing_item_entity.dart';
import 'package:zilant_look/features/inventory/domain/repositories/inventory_repository.dart';

class GetInventoryItemsUseCase {
  final InventoryRepository repository;

  GetInventoryItemsUseCase({required this.repository});

  Future<List<ClothingItemEntity>> call() async {
    return await repository.getInventoryItems();
  }
}
