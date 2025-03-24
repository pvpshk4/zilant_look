import 'package:equatable/equatable.dart';

abstract class PhotoUploadEvent extends Equatable {
  const PhotoUploadEvent();

  @override
  List<Object> get props => [];
}

class ChoosePhotoFromGalleryEvent extends PhotoUploadEvent {
  final String username;

  const ChoosePhotoFromGalleryEvent({required this.username});

  @override
  List<Object> get props => [username];
}

class TakePhotoFromCameraEvent extends PhotoUploadEvent {
  final String username;

  const TakePhotoFromCameraEvent({required this.username});

  @override
  List<Object> get props => [username];
}
