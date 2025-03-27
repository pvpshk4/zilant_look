import 'dart:io';
import 'package:equatable/equatable.dart';

abstract class PhotoUploadEvent extends Equatable {
  const PhotoUploadEvent();
}

class ChoosePhotoFromGalleryEvent extends PhotoUploadEvent {
  final String username;
  final String? subcategory;

  const ChoosePhotoFromGalleryEvent({required this.username, this.subcategory});

  @override
  List<Object?> get props => [username, subcategory];
}

class TakePhotoFromCameraEvent extends PhotoUploadEvent {
  final String username;
  final String? subcategory;

  const TakePhotoFromCameraEvent({required this.username, this.subcategory});

  @override
  List<Object?> get props => [username, subcategory];
}

class UploadPhotoEvent extends PhotoUploadEvent {
  final File file;
  final String username;
  final String? subcategory;

  const UploadPhotoEvent({
    required this.file,
    required this.username,
    this.subcategory,
  });

  @override
  List<Object?> get props => [file, username, subcategory];
}
