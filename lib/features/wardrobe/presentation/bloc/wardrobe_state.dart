import 'package:equatable/equatable.dart';

import '../../../../common/domain/entities/clothing_item_entity.dart';

abstract class WardrobeState extends Equatable {
  const WardrobeState();

  @override
  List<Object> get props => [];
}

class WardrobeInitialState extends WardrobeState {}

class WardrobeLoadingState extends WardrobeState {}

class WardrobeLoadedState extends WardrobeState {
  final List<ClothingItemEntity> items;

  const WardrobeLoadedState(this.items);

  @override
  List<Object> get props => [items];
}

class WardrobeFilteredState extends WardrobeState {
  final List<ClothingItemEntity> items;

  const WardrobeFilteredState(this.items);

  @override
  List<Object> get props => [items];
}

class WardrobeErrorState extends WardrobeState {
  final String message;

  const WardrobeErrorState(this.message);

  @override
  List<Object> get props => [message];
}
