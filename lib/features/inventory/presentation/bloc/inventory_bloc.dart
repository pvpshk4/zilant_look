import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zilant_look/common/domain/entities/clothing_item_entity.dart';

import '../../domain/usecases/inventory_usecases_exports.dart';
import 'inventory_event.dart';
import 'inventory_state.dart';

class InventoryBloc extends Bloc<InventoryEvent, InventoryState> {
  final GetInventoryItemsUseCase getInventoryItems;
  final FilterInventoryByCategoryUseCase filterInventoryByCategory;
  final AddClothingItemUseCase addClothingItem;
  final DeleteClothingItemUseCase deleteClothingItem;
  final UpdateClothingItemUseCase updateClothingItem;

  InventoryBloc({
    required this.getInventoryItems,
    required this.filterInventoryByCategory,
    required this.addClothingItem,
    required this.deleteClothingItem,
    required this.updateClothingItem,
  }) : super(InventoryInitialState());

  Stream<InventoryState> mapEventToState(InventoryEvent event) async* {
    if (event is LoadInventoryEvent) {
      yield InventoryLoadingState();
      try {
        final items = await getInventoryItems();
        yield InventoryLoadedState(items);
      } catch (e) {
        yield InventoryErrorState('Failed to load inventory: $e');
      }
    } else if (event is FilterInventoryByCategoryEvent) {
      yield InventoryLoadingState();
      try {
        final items = await filterInventoryByCategory(event.category);
        yield InventoryFilteredState(items);
      } catch (e) {
        yield InventoryErrorState('Failed to filter inventory: $e');
      }
    } else if (event is AddClothingItemEvent) {
      yield InventoryLoadingState();
      try {
        await addClothingItem(event.item);
        final items = await getInventoryItems();
        yield InventoryLoadedState(items);
      } catch (e) {
        yield InventoryErrorState('Failed to add item: $e');
      }
    } else if (event is DeleteClothingItemEvent) {
      yield InventoryLoadingState();
      try {
        await deleteClothingItem(event.id);
        final items = await getInventoryItems();
        yield InventoryLoadedState(items);
      } catch (e) {
        yield InventoryErrorState('Failed to delete item: $e');
      }
    } else if (event is UpdateClothingItemEvent) {
      yield InventoryLoadingState();
      try {
        await updateClothingItem(event.item);
        final items = await getInventoryItems();
        yield InventoryLoadedState(items);
      } catch (e) {
        yield InventoryErrorState('Failed to update item: $e');
      }
    } else if (event is AddPhotoToInventoryEvent) {
      yield InventoryLoadingState();
      try {
        final clothingItem = ClothingItemEntity(
          id: 'generated_id',
          name: 'Photo',
          imageUrl: event.filePath,
          category: 'Photos',
        );
        await addClothingItem(clothingItem);
        final items = await getInventoryItems();
        yield InventoryLoadedState(items);
      } catch (e) {
        yield InventoryErrorState('Failed to add photo to inventory" $e');
      }
    }
  }
}
