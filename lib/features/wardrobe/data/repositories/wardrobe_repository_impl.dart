import 'package:zilant_look/common/data/models/clothing_item_model.dart';
import 'package:zilant_look/common/domain/entities/clothing_item_entity.dart';
import 'package:zilant_look/features/wardrobe/data/data_sources/remote/wardrobe_remote_data_source.dart';
import 'package:zilant_look/features/wardrobe/domain/repositories/wardrobe_repository.dart';

class WardrobeRepositoryImpl implements WardrobeRepository {
  final WardrobeRemoteDataSourceImpl _wardrobeRemoteDataSource;

  WardrobeRepositoryImpl(this._wardrobeRemoteDataSource);

  @override
  Future<List<ClothingItemEntity>> getWardrobeItems() async {
    final List<ClothingItemModel> items =
        await _wardrobeRemoteDataSource.getWardrobeItems();
    return items.map((model) => model.toEntity()).toList();
  }

  @override
  Future<List<ClothingItemEntity>> filterWardrobeByCategory(
    String category,
  ) async {
    final List<ClothingItemModel> items = await _wardrobeRemoteDataSource
        .filterWardrobeByCategory(category);
    return items.map((model) => model.toEntity()).toList();
  }

  @override
  Future<void> addClothingItem(ClothingItemEntity item) async {
    final ClothingItemModel model = item.toModel();
    await _wardrobeRemoteDataSource.addClothingItem(model);
  }

  @override
  Future<void> deleteClothingItem(String id) async {
    await _wardrobeRemoteDataSource.deleteClothingItem(id);
  }

  @override
  Future<void> updateClothingItem(ClothingItemEntity item) async {
    final ClothingItemModel model = item.toModel();
    await _wardrobeRemoteDataSource.updateClothingItem(model);
  }
}
