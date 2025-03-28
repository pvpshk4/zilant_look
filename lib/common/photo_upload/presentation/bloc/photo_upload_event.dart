import 'dart:io';
import 'package:equatable/equatable.dart';

abstract class PhotoUploadEvent extends Equatable {
  const PhotoUploadEvent();
}

class ChoosePhotoFromGalleryEvent extends PhotoUploadEvent {
  final String username;
  final String? category;
  final String? subcategory;
  final String? sub_subcategory;

  const ChoosePhotoFromGalleryEvent({
    required this.username,
    this.category,
    this.subcategory,
    this.sub_subcategory,
  });

  @override
  List<Object?> get props => [username, category, subcategory, sub_subcategory];
}

class TakePhotoFromCameraEvent extends PhotoUploadEvent {
  final String username;
  final String? category;
  final String? subcategory;
  final String? sub_subcategory;

  const TakePhotoFromCameraEvent({
    required this.username,
    this.category,
    this.subcategory,
    this.sub_subcategory,
  });

  @override
  List<Object?> get props => [username, category, subcategory, sub_subcategory];
}

class UploadPhotoEvent extends PhotoUploadEvent {
  final File file;
  final String username;
  final String? category;
  final String? subcategory;
  final String? sub_subcategory;

  const UploadPhotoEvent({
    required this.file,
    required this.username,
    this.category,
    this.subcategory,
    this.sub_subcategory,
  });

  @override
  List<Object?> get props => [
    file,
    username,
    category,
    subcategory,
    sub_subcategory,
  ];
}
