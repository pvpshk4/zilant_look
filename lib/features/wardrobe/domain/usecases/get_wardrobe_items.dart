import 'package:zilant_look/common/domain/entities/clothing_item_entity.dart';
import 'package:zilant_look/features/wardrobe/data/repositories/wardrobe_repository_impl.dart';

class GetWardrobeItemsUseCase {
  final WardrobeRepositoryImpl _wardrobeRepositoryImpl;

  GetWardrobeItemsUseCase(this._wardrobeRepositoryImpl);

  Future<List<ClothingItemEntity>> call({
    required int limit,
    required int offset,
  }) async {
    return await _wardrobeRepositoryImpl.getWardrobeItems(
      limit: limit,
      offset: offset,
    );
  }
}
