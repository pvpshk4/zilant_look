import 'package:equatable/equatable.dart';

import '../../../../common/domain/entities/clothing_item_entity.dart';

abstract class InventoryEvent extends Equatable {
  const InventoryEvent();

  @override
  List<Object> get props => [];
}

class LoadInventoryEvent extends InventoryEvent {}

class FilterInventoryByCategoryEvent extends InventoryEvent {
  final String category;

  const FilterInventoryByCategoryEvent(this.category);

  @override
  List<Object> get props => [category];
}

class AddClothingItemEvent extends InventoryEvent {
  final ClothingItemEntity item;

  const AddClothingItemEvent(this.item);

  @override
  List<Object> get props => [item];
}

class DeleteClothingItemEvent extends InventoryEvent {
  final String id;

  const DeleteClothingItemEvent(this.id);

  @override
  List<Object> get props => [id];
}

class UpdateClothingItemEvent extends InventoryEvent {
  final ClothingItemEntity item;

  const UpdateClothingItemEvent(this.item);

  @override
  List<Object> get props => [item];
}

class AddPhotoToInventoryEvent extends InventoryEvent {
  final String filePath;

  const AddPhotoToInventoryEvent(this.filePath);

  @override
  List<Object> get props => [filePath];
}
