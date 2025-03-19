import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:zilant_look/common/photo_upload/domain/usecases/photo_upload.dart';
import 'package:zilant_look/common/photo_upload/presentation/bloc/photo_upload_event.dart';
import 'package:zilant_look/common/photo_upload/presentation/bloc/photo_upload_state.dart';

class PhotoUploadBloc extends Bloc<PhotoUploadEvent, PhotoUploadState> {
  final UploadPhotoUseCase uploadPhoto;
  final ImagePicker _picker = ImagePicker();

  PhotoUploadBloc({required this.uploadPhoto})
    : super(PhotoUploadInitialState()) {
    on<TakePhotoFromCameraEvent>(_onTakePhotoFromCamera);
    on<ChoosePhotoFromGalleryEvent>(_onChoosePhotoFromGallery);
  }

  Future<void> _onTakePhotoFromCamera(
    TakePhotoFromCameraEvent event,
    Emitter<PhotoUploadState> emit,
  ) async {
    emit(PhotoUploadLoadingState());
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.camera);
      if (image != null) {
        final photoEntity = await uploadPhoto(File(image.path));
        emit(PhotoUploadSuccessState(photo: photoEntity));
      } else {
        emit(const PhotoUploadFailureState(message: 'No image selected'));
      }
    } catch (e) {
      emit(PhotoUploadFailureState(message: e.toString()));
    }
  }

  Future<void> _onChoosePhotoFromGallery(
    ChoosePhotoFromGalleryEvent event,
    Emitter<PhotoUploadState> emit,
  ) async {
    emit(PhotoUploadLoadingState());
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        final photoEntity = await uploadPhoto(File(image.path));
        emit(PhotoUploadSuccessState(photo: photoEntity));
      } else {
        emit(const PhotoUploadFailureState(message: 'No image selected'));
      }
    } catch (e) {
      emit(PhotoUploadFailureState(message: e.toString()));
    }
  }
}
