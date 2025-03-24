import 'package:zilant_look/common/domain/entities/clothing_item_entity.dart';
import 'package:zilant_look/features/wardrobe/data/repositories/wardrobe_repository_impl.dart';

class FilterWardrobeByCategoryUseCase {
  final WardrobeRepositoryImpl _wardrobeRepositoryImpl;

  FilterWardrobeByCategoryUseCase(this._wardrobeRepositoryImpl);

  Future<List<ClothingItemEntity>> call(String category) async {
    return await _wardrobeRepositoryImpl.filterWardrobeByCategory(category);
  }
}
