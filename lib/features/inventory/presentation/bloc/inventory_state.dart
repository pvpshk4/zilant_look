import 'package:equatable/equatable.dart';

import '../../../../common/domain/entities/clothing_item_entity.dart';

abstract class InventoryState extends Equatable {
  const InventoryState();

  @override
  List<Object> get props => [];
}

class InventoryInitialState extends InventoryState {}

class InventoryLoadingState extends InventoryState {}

class InventoryLoadedState extends InventoryState {
  final List<ClothingItemEntity> items;

  const InventoryLoadedState(this.items);

  @override
  List<Object> get props => [items];
}

class InventoryFilteredState extends InventoryState {
  final List<ClothingItemEntity> items;

  const InventoryFilteredState(this.items);

  @override
  List<Object> get props => [items];
}

class InventoryErrorState extends InventoryState {
  final String message;

  const InventoryErrorState(this.message);

  @override
  List<Object> get props => [message];
}
