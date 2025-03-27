import 'package:equatable/equatable.dart';

import '../../../../common/domain/entities/clothing_item_entity.dart';

abstract class WardrobeEvent extends Equatable {
  const WardrobeEvent();

  @override
  List<Object> get props => [];
}

class LoadWardrobeEvent extends WardrobeEvent {}

class LoadMoreWardrobeItemsEvent extends WardrobeEvent {
  final int limit;
  final int offset;

  const LoadMoreWardrobeItemsEvent({required this.limit, required this.offset});
}

class FilterWardrobeByCategoryEvent extends WardrobeEvent {
  final String category;
  final String subcategory;
  final String filter;

  const FilterWardrobeByCategoryEvent({
    required this.category,
    required this.subcategory,
    required this.filter,
  });
}

class DeleteClothingItemEvent extends WardrobeEvent {
  final String id;

  const DeleteClothingItemEvent(this.id);

  @override
  List<Object> get props => [id];
}

class UpdateClothingItemEvent extends WardrobeEvent {
  final ClothingItemEntity item;

  const UpdateClothingItemEvent(this.item);

  @override
  List<Object> get props => [item];
}

class AddPhotoToWardrobeEvent extends WardrobeEvent {
  final String filePath;

  const AddPhotoToWardrobeEvent(this.filePath);

  @override
  List<Object> get props => [filePath];
}
