import 'package:zilant_look/common/domain/entities/clothing_item_entity.dart';
import 'package:zilant_look/features/wardrobe/data/repositories/wardrobe_repository_impl.dart';

class UpdateClothingItemUseCase {
  final WardrobeRepositoryImpl _wardrobeRepositoryImpl;

  UpdateClothingItemUseCase(this._wardrobeRepositoryImpl);

  Future<void> call(ClothingItemEntity item) async {
    return await _wardrobeRepositoryImpl.updateClothingItem(item);
  }
}
