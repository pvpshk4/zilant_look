import 'package:equatable/equatable.dart';
import '../../domain/entities/photo_entity.dart';

abstract class PhotoUploadState extends Equatable {
  const PhotoUploadState();

  @override
  List<Object> get props => [];
}

class PhotoUploadInitialState extends PhotoUploadState {}

class PhotoUploadLoadingState extends PhotoUploadState {}

class PhotoUploadSuccessState extends PhotoUploadState {
  final PhotoEntity photo;

  const PhotoUploadSuccessState({required this.photo});

  @override
  List<Object> get props => [photo];
}

class PhotoUploadFailureState extends PhotoUploadState {
  final String message;

  const PhotoUploadFailureState({required this.message});

  @override
  List<Object> get props => [message];
}

class PhotoUploadImageSelectedState extends PhotoUploadState {
  final String imagePath;

  const PhotoUploadImageSelectedState({required this.imagePath});

  @override
  List<Object> get props => [imagePath];
}

class CategorySelectionState extends PhotoUploadState {
  final String category;
  final String subcategory;
  final String subSubcategory;

  const CategorySelectionState({
    required this.category,
    required this.subcategory,
    required this.subSubcategory,
  });

  @override
  List<Object> get props => [category, subcategory, subSubcategory];
}
