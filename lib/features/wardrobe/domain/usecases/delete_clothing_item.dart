import 'package:zilant_look/features/wardrobe/data/repositories/wardrobe_repository_impl.dart';

class DeleteClothingItemUseCase {
  final WardrobeRepositoryImpl _wardrobeRepositoryImpl;

  DeleteClothingItemUseCase(this._wardrobeRepositoryImpl);

  Future<void> call(String id) async {
    return await _wardrobeRepositoryImpl.deleteClothingItem(id);
  }
}
