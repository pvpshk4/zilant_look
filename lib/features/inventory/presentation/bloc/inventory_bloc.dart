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
  }) : super(InventoryInitialState()) {
    on<LoadInventoryEvent>(_onLoadInventory);
    on<FilterInventoryByCategoryEvent>(_onFilterInventory);
    on<AddClothingItemEvent>(_onAddClothingItem);
    on<DeleteClothingItemEvent>(_onDeleteClothingItem);
    on<UpdateClothingItemEvent>(_onUpdateClothingItem);
    on<AddPhotoToInventoryEvent>(_onAddPhotoToInventory);
  }

  Future<void> _onLoadInventory(
    LoadInventoryEvent event,
    Emitter<InventoryState> emit,
  ) async {
    emit(InventoryLoadingState());
    try {
      final items = await getInventoryItems();
      emit(InventoryLoadedState(items));
    } catch (e) {
      emit(InventoryErrorState('Failed to load inventory: $e'));
    }
  }

  Future<void> _onFilterInventory(
    FilterInventoryByCategoryEvent event,
    Emitter<InventoryState> emit,
  ) async {
    emit(InventoryLoadingState());
    try {
      final items = await filterInventoryByCategory(event.category);
      emit(InventoryFilteredState(items));
    } catch (e) {
      emit(InventoryErrorState('Failed to filter inventory: $e'));
    }
  }

  Future<void> _onAddClothingItem(
    AddClothingItemEvent event,
    Emitter<InventoryState> emit,
  ) async {
    emit(InventoryLoadingState());
    try {
      await addClothingItem(event.item);
      final items = await getInventoryItems();
      emit(InventoryLoadedState(items));
    } catch (e) {
      emit(InventoryErrorState('Failed to add item: $e'));
    }
  }

  Future<void> _onDeleteClothingItem(
    DeleteClothingItemEvent event,
    Emitter<InventoryState> emit,
  ) async {
    emit(InventoryLoadingState());
    try {
      await deleteClothingItem(event.id);
      final items = await getInventoryItems();
      emit(InventoryLoadedState(items));
    } catch (e) {
      emit(InventoryErrorState('Failed to delete item: $e'));
    }
  }

  Future<void> _onUpdateClothingItem(
    UpdateClothingItemEvent event,
    Emitter<InventoryState> emit,
  ) async {
    emit(InventoryLoadingState());
    try {
      await updateClothingItem(event.item);
      final items = await getInventoryItems();
      emit(InventoryLoadedState(items));
    } catch (e) {
      emit(InventoryErrorState('Failed to update item: $e'));
    }
  }

  Future<void> _onAddPhotoToInventory(
    AddPhotoToInventoryEvent event,
    Emitter<InventoryState> emit,
  ) async {
    emit(InventoryLoadingState());
    try {
      final clothingItem = ClothingItemEntity(
        id: 'generated_id', // Замените на реальный ID
        name: 'Photo',
        imageUrl: event.filePath,
        category: 'Photos',
      );
      await addClothingItem(clothingItem);
      final items = await getInventoryItems();
      emit(InventoryLoadedState(items));
    } catch (e) {
      emit(InventoryErrorState('Failed to add photo to inventory: $e'));
    }
  }
}
