// wardrobe_repository_impl.dart
import 'package:zilant_look/common/data/models/clothing_item_model.dart';
import 'package:zilant_look/common/domain/entities/clothing_item_entity.dart';
import 'package:zilant_look/features/wardrobe/data/data_sources/local/wardrobe_local_data_source.dart';
import 'package:zilant_look/features/wardrobe/data/data_sources/remote/wardrobe_remote_data_source.dart';
import '../../domain/repositories/wardrobe_repository.dart';

class WardrobeRepositoryImpl implements WardrobeRepository {
  final WardrobeRemoteDataSourceImpl _remoteDataSource;
  final WardrobeLocalDataSourceImpl _localDataSource;

  WardrobeRepositoryImpl({
    required WardrobeRemoteDataSourceImpl remoteDataSource,
    required WardrobeLocalDataSourceImpl localDataSource,
  }) : _remoteDataSource = remoteDataSource,
       _localDataSource = localDataSource;

  @override
  Future<List<ClothingItemEntity>> getWardrobeItems({
    required int limit,
    required int offset,
  }) async {
    // Попытка получить данные из кэша
    final cachedModels = await _localDataSource.getCachedWardrobeItems();
    if (cachedModels.isNotEmpty) {
      return cachedModels
          .map((model) => ClothingItemModel.toEntity(model))
          .toList();
    }

    // Если кэш пуст, загружаем данные с сервера
    final remoteModels = await _remoteDataSource.getWardrobeItems(
      limit: limit,
      offset: offset,
    );
    await _localDataSource.cacheWardrobeItems(remoteModels); // Сохраняем в кэш
    return remoteModels
        .map((model) => ClothingItemModel.toEntity(model))
        .toList();
  }

  @override
  Future<List<ClothingItemEntity>> filterWardrobeByCategory(
    String category,
  ) async {
    // Получаем кэшированные данные
    final cachedModels = await _localDataSource.getCachedWardrobeItems();
    final filteredModels =
        cachedModels.where((model) => model.category == category).toList();
    return filteredModels
        .map((model) => ClothingItemModel.toEntity(model))
        .toList();
  }

  @override
  Future<void> deleteClothingItem(String id) async {
    await _remoteDataSource.deleteClothingItem(id);
    // Обновляем кэш после удаления
    final cachedModels = await _localDataSource.getCachedWardrobeItems();
    final updatedModels =
        cachedModels.where((model) => model.id != id).toList();
    await _localDataSource.cacheWardrobeItems(updatedModels);
  }

  @override
  Future<void> updateClothingItem(ClothingItemEntity item) async {
    final updatedModel = ClothingItemModel.fromEntity(item);
    await _remoteDataSource.updateClothingItem(updatedModel);
    // Обновляем кэш после изменения
    final cachedModels = await _localDataSource.getCachedWardrobeItems();
    final updatedModels =
        cachedModels.map((model) {
          if (model.id == updatedModel.id) {
            return updatedModel;
          }
          return model;
        }).toList();
    await _localDataSource.cacheWardrobeItems(updatedModels);
  }
}
