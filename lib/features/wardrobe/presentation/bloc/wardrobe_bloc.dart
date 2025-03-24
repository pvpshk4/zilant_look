import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zilant_look/common/domain/entities/clothing_item_entity.dart';

import '../../domain/usecases/wardrobe_usecases_exports.dart';
import 'wardrobe_event.dart';
import 'wardrobe_state.dart';

class WardrobeBloc extends Bloc<WardrobeEvent, WardrobeState> {
  final GetWardrobeItemsUseCase getWardrobeItems;
  final FilterWardrobeByCategoryUseCase filterWardrobeByCategory;
  final AddClothingItemUseCase addClothingItem;
  final DeleteClothingItemUseCase deleteClothingItem;
  final UpdateClothingItemUseCase updateClothingItem;

  WardrobeBloc({
    required this.getWardrobeItems,
    required this.filterWardrobeByCategory,
    required this.addClothingItem,
    required this.deleteClothingItem,
    required this.updateClothingItem,
  }) : super(WardrobeInitialState()) {
    on<LoadWardrobeEvent>(_onLoadWardrobe);
    on<FilterWardrobeByCategoryEvent>(_onFilterWardrobe);
    on<AddClothingItemEvent>(_onAddClothingItem);
    on<DeleteClothingItemEvent>(_onDeleteClothingItem);
    on<UpdateClothingItemEvent>(_onUpdateClothingItem);
    on<AddPhotoToWardrobeEvent>(_onAddPhotoToWardrobe);
  }

  Future<void> _onLoadWardrobe(
    LoadWardrobeEvent event,
    Emitter<WardrobeState> emit,
  ) async {
    emit(WardrobeLoadingState());
    try {
      final items = await getWardrobeItems();
      emit(WardrobeLoadedState(items));
    } catch (e) {
      emit(WardrobeErrorState('Failed to load wardrobe: $e'));
    }
  }

  Future<void> _onFilterWardrobe(
    FilterWardrobeByCategoryEvent event,
    Emitter<WardrobeState> emit,
  ) async {
    emit(WardrobeLoadingState());
    try {
      final items = await filterWardrobeByCategory(event.category);
      emit(WardrobeFilteredState(items));
    } catch (e) {
      emit(WardrobeErrorState('Failed to filter wardrobe: $e'));
    }
  }

  Future<void> _onAddClothingItem(
    AddClothingItemEvent event,
    Emitter<WardrobeState> emit,
  ) async {
    emit(WardrobeLoadingState());
    try {
      await addClothingItem(event.item);
      final items = await getWardrobeItems();
      emit(WardrobeLoadedState(items));
    } catch (e) {
      emit(WardrobeErrorState('Failed to add item: $e'));
    }
  }

  Future<void> _onDeleteClothingItem(
    DeleteClothingItemEvent event,
    Emitter<WardrobeState> emit,
  ) async {
    emit(WardrobeLoadingState());
    try {
      await deleteClothingItem(event.id);
      final items = await getWardrobeItems();
      emit(WardrobeLoadedState(items));
    } catch (e) {
      emit(WardrobeErrorState('Failed to delete item: $e'));
    }
  }

  Future<void> _onUpdateClothingItem(
    UpdateClothingItemEvent event,
    Emitter<WardrobeState> emit,
  ) async {
    emit(WardrobeLoadingState());
    try {
      await updateClothingItem(event.item);
      final items = await getWardrobeItems();
      emit(WardrobeLoadedState(items));
    } catch (e) {
      emit(WardrobeErrorState('Failed to update item: $e'));
    }
  }

  Future<void> _onAddPhotoToWardrobe(
    AddPhotoToWardrobeEvent event,
    Emitter<WardrobeState> emit,
  ) async {
    emit(WardrobeLoadingState());
    try {
      final clothingItem = ClothingItemEntity(
        id: 'generated_id',
        name: 'Photo',
        imageUrl: event.filePath,
        category: 'Photos',
      );
      await addClothingItem(clothingItem);
      final items = await getWardrobeItems();
      emit(WardrobeLoadedState(items));
    } catch (e) {
      emit(WardrobeErrorState('Failed to add photo to wardrobe: $e'));
    }
  }
}
