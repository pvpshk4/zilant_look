import 'package:zilant_look/common/domain/entities/clothing_item_entity.dart';

import '../repositories/wardrobe_repository.dart';

class UpdateClothingItemUseCase {
  final WardrobeRepository _wardrobeRepository;

  UpdateClothingItemUseCase(this._wardrobeRepository);

  Future<void> call(ClothingItemEntity item) async {
    return await _wardrobeRepository.updateClothingItem(item);
  }
}
