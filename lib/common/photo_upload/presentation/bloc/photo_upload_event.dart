import 'package:equatable/equatable.dart';

abstract class PhotoUploadEvent extends Equatable {
  const PhotoUploadEvent();

  @override
  List<Object?> get props => [];
}

class TakePhotoFromCameraEvent extends PhotoUploadEvent {
  const TakePhotoFromCameraEvent();
}

class ChoosePhotoFromGalleryEvent extends PhotoUploadEvent {
  const ChoosePhotoFromGalleryEvent();
}

class SelectCategoryEvent extends PhotoUploadEvent {
  final String category;
  final String subcategory;
  final String subSubcategory;

  const SelectCategoryEvent({
    required this.category,
    required this.subcategory,
    required this.subSubcategory,
  });

  @override
  List<Object?> get props => [category, subcategory, subSubcategory];
}

class SavePhotoEvent extends PhotoUploadEvent {
  const SavePhotoEvent();
}

class CancelPhotoUploadEvent extends PhotoUploadEvent {
  const CancelPhotoUploadEvent();
}
