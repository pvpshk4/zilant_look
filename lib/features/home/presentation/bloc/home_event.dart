import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object?> get props => [];
}

class LoadHomeDataEvent extends HomeEvent {}

class SelectCategoryEvent extends HomeEvent {
  final String categoryName;
  final bool isCatalogTab;

  const SelectCategoryEvent(this.categoryName, {required this.isCatalogTab});

  @override
  List<Object?> get props => [categoryName, isCatalogTab];
}

class SelectSubcategoryEvent extends HomeEvent {
  final String subcategoryName;
  final bool isCatalogTab;

  const SelectSubcategoryEvent(
    this.subcategoryName, {
    required this.isCatalogTab,
  });

  @override
  List<Object?> get props => [subcategoryName, isCatalogTab];
}

class SelectSubSubcategoryEvent extends HomeEvent {
  final String subSubcategoryName;
  final bool isCatalogTab;

  const SelectSubSubcategoryEvent(
    this.subSubcategoryName, {
    required this.isCatalogTab,
  });

  @override
  List<Object?> get props => [subSubcategoryName, isCatalogTab];
}

class ResetFilterEvent extends HomeEvent {
  final bool isCatalogTab;

  const ResetFilterEvent({required this.isCatalogTab});

  @override
  List<Object?> get props => [isCatalogTab];
}

class GoToPreviousEvent extends HomeEvent {
  final int level;
  final bool isCatalogTab;

  const GoToPreviousEvent(this.level, {required this.isCatalogTab});

  @override
  List<Object?> get props => [level, isCatalogTab];
}
