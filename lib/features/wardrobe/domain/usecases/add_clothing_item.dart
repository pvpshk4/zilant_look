import 'package:zilant_look/common/domain/entities/clothing_item_entity.dart';
import 'package:zilant_look/features/wardrobe/data/repositories/wardrobe_repository_impl.dart';

class AddClothingItemUseCase {
  final WardrobeRepositoryImpl _wardrobeRepositoryImpl;

  AddClothingItemUseCase(this._wardrobeRepositoryImpl);

  Future<void> call(ClothingItemEntity item) async {
    return await _wardrobeRepositoryImpl.addClothingItem(item);
  }
}
