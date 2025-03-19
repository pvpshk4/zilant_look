import 'package:zilant_look/common/data/models/clothing_item_model.dart';
import 'package:zilant_look/common/domain/entities/clothing_item_entity.dart';
import 'package:zilant_look/features/inventory/data/data_sources/remote/inventory_remote_data_source.dart';
import 'package:zilant_look/features/inventory/domain/repositories/inventory_repository.dart';

class InventoryRepositoryImpl implements InventoryRepository {
  final InventoryRemoteDataSourceImpl remoteDataSource;

  InventoryRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<ClothingItemEntity>> getInventoryItems() async {
    final List<ClothingItemModel> items =
        await remoteDataSource.getInventoryItems();
    return items.map((model) => model.toEntity()).toList();
  }

  @override
  Future<List<ClothingItemEntity>> filterInventoryByCategory(
    String category,
  ) async {
    final List<ClothingItemModel> items = await remoteDataSource
        .filterInventoryByCategory(category);
    return items.map((model) => model.toEntity()).toList();
  }

  @override
  Future<void> addClothingItem(ClothingItemEntity item) async {
    final ClothingItemModel model = item.toModel();
    await remoteDataSource.addClothingItem(model);
  }

  @override
  Future<void> deleteClothingItem(String id) async {
    await remoteDataSource.deleteClothingItem(id);
  }

  @override
  Future<void> updateClothingItem(ClothingItemEntity item) async {
    final ClothingItemModel model = item.toModel();
    await remoteDataSource.updateClothingItem(model);
  }
}
