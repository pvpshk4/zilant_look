import 'package:equatable/equatable.dart';
import 'package:zilant_look/common/photo_upload/domain/entities/photo_entity.dart';

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
