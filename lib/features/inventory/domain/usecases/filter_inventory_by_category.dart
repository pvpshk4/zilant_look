import 'package:zilant_look/common/domain/entities/clothing_item_entity.dart';

import '../repositories/inventory_repository.dart';

class FilterInventoryByCategoryUseCase {
  final InventoryRepository repository;

  FilterInventoryByCategoryUseCase({required this.repository});

  Future<List<ClothingItemEntity>> call(String category) async {
    return await repository.filterInventoryByCategory(category);
  }
}
