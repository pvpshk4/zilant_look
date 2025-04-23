import 'package:equatable/equatable.dart';
import 'package:zilant_look/common/data/models/photo_model.dart';

class AppDataState extends Equatable {
  final List<String> humanPhotos;
  final List<PhotoModel> clothingItems;
  final bool isLoading;
  final String? error;

  const AppDataState({
    this.humanPhotos = const [],
    this.clothingItems = const [],
    this.isLoading = false,
    this.error,
  });

  AppDataState copyWith({
    List<String>? humanPhotos,
    List<PhotoModel>? clothingItems,
    bool? isLoading,
    String? error,
  }) {
    return AppDataState(
      humanPhotos: humanPhotos ?? this.humanPhotos,
      clothingItems: clothingItems ?? this.clothingItems,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [humanPhotos, clothingItems, isLoading, error];
}
