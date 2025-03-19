import 'package:equatable/equatable.dart';

abstract class PhotoUploadEvent extends Equatable {
  const PhotoUploadEvent();

  @override
  List<Object> get props => [];
}

class ChoosePhotoFromGalleryEvent extends PhotoUploadEvent {
  final String filePath;

  const ChoosePhotoFromGalleryEvent({required this.filePath});

  @override
  List<Object> get props => [filePath];
}

class TakePhotoFromCameraEvent extends PhotoUploadEvent {}
