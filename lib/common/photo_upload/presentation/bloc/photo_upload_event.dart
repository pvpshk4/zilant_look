import 'package:equatable/equatable.dart';

abstract class PhotoUploadEvent extends Equatable {
  const PhotoUploadEvent();

  @override
  List<Object> get props => [];
}

class UploadPhotoEvent extends PhotoUploadEvent {
  final String filePath;

  const UploadPhotoEvent({required this.filePath});

  @override
  List<Object> get props => [filePath];
}
