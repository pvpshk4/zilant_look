// wardrobe_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zilant_look/common/domain/entities/clothing_item_entity.dart';
import '../../domain/usecases/wardrobe_usecases_exports.dart';
import 'wardrobe_event.dart';
import 'wardrobe_state.dart';

class WardrobeBloc extends Bloc<WardrobeEvent, WardrobeState> {
  final GetWardrobeItemsUseCase getWardrobeItems;
  final FilterWardrobeByCategoryUseCase filterWardrobeByCategory;
  final DeleteClothingItemUseCase deleteClothingItem;
  final UpdateClothingItemUseCase updateClothingItem;

  List<ClothingItemEntity> _allItems = []; // Все элементы гардероба

  WardrobeBloc({
    required this.getWardrobeItems,
    required this.filterWardrobeByCategory,
    required this.deleteClothingItem,
    required this.updateClothingItem,
  }) : super(WardrobeInitialState()) {
    on<LoadWardrobeEvent>(_onLoadWardrobe);
    on<LoadMoreWardrobeItemsEvent>(_onLoadMoreWardrobe);
    on<FilterWardrobeByCategoryEvent>(_onFilterWardrobe);
    on<DeleteClothingItemEvent>(_onDeleteClothingItem);
    on<UpdateClothingItemEvent>(_onUpdateClothingItem);
  }

  Future<void> _onLoadWardrobe(
    LoadWardrobeEvent event,
    Emitter<WardrobeState> emit,
  ) async {
    emit(WardrobeLoadingState());
    try {
      _allItems = await getWardrobeItems(
        limit: 10,
        offset: 0,
      ); // Первые 10 элементов
      emit(WardrobeLoadedState(_allItems));
    } catch (e) {
      emit(WardrobeErrorState('Failed to load wardrobe: $e'));
    }
  }

  Future<void> _onLoadMoreWardrobe(
    LoadMoreWardrobeItemsEvent event,
    Emitter<WardrobeState> emit,
  ) async {
    if (state is WardrobeLoadedState) {
      final currentState = state as WardrobeLoadedState;
      emit(WardrobeLoadingMoreState());
      try {
        final newItems = await getWardrobeItems(
          limit: event.limit,
          offset: currentState.items.length,
        );
        final updatedItems = [...currentState.items, ...newItems];
        emit(WardrobeLoadedState(updatedItems));
      } catch (e) {
        emit(WardrobeErrorState('Failed to load more items: $e'));
      }
    }
  }

  Future<void> _onFilterWardrobe(
    FilterWardrobeByCategoryEvent event,
    Emitter<WardrobeState> emit,
  ) async {
    emit(WardrobeLoadingState());
    try {
      final filteredItems = await filterWardrobeByCategory(
        category: event.category,
        subcategory: event.subcategory,
        filter: event.filter,
      );
      emit(WardrobeFilteredState(filteredItems));
    } catch (e) {
      emit(WardrobeErrorState('Failed to filter wardrobe: $e'));
    }
  }

  Future<void> _onDeleteClothingItem(
    DeleteClothingItemEvent event,
    Emitter<WardrobeState> emit,
  ) async {
    emit(WardrobeLoadingState());
    try {
      await deleteClothingItem(event.id);
      _allItems.removeWhere((item) => item.id == event.id);
      emit(WardrobeLoadedState(_allItems));
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
      _allItems =
          _allItems.map((item) {
            if (item.id == event.item.id) {
              return event.item;
            }
            return item;
          }).toList();
      emit(WardrobeLoadedState(_allItems));
    } catch (e) {
      emit(WardrobeErrorState('Failed to update item: $e'));
    }
  }
}
