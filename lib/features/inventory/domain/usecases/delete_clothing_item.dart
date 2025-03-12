import 'package:zilant_look/features/inventory/domain/repositories/inventory_repository.dart';

class DeleteClothingItemUseCase {
  final InventoryRepository repository;

  DeleteClothingItemUseCase({required this.repository});

  Future<void> call(String id) async {
    return await repository.deleteClothingItem(id);
  }
}
