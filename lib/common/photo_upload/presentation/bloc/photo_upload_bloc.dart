// features/photo_upload/presentation/bloc/photo_upload_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/photo_upload.dart';
import 'photo_upload_event.dart';
import 'photo_upload_state.dart';

class PhotoUploadBloc extends Bloc<PhotoUploadEvent, PhotoUploadState> {
  final UploadPhotoUseCase uploadPhoto;

  PhotoUploadBloc({required this.uploadPhoto})
    : super(PhotoUploadInitialState());

  Stream<PhotoUploadState> mapEventToState(PhotoUploadEvent event) async* {
    if (event is UploadPhotoEvent) {
      yield PhotoUploadLoadingState();
      try {
        final photo = await uploadPhoto(event.filePath);
        yield PhotoUploadSuccessState(photo: photo);
      } catch (e) {
        yield PhotoUploadFailureState(message: 'Failed to upload photo: $e');
      }
    }
  }
}
