import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../domain/usecases/upload_clothes_photo_usecase.dart';
import '../../domain/usecases/upload_human_photo_usecase.dart';
import 'package:zilant_look/common/photo_upload/presentation/bloc/photo_upload_event.dart';
import 'package:zilant_look/common/photo_upload/presentation/bloc/photo_upload_state.dart';

class PhotoUploadBloc extends Bloc<PhotoUploadEvent, PhotoUploadState> {
  final UploadClothesPhotoUsecase uploadClothesPhoto;
  final UploadHumanPhotoUsecase uploadHumanPhoto;
  final ImagePicker _picker = ImagePicker();

  PhotoUploadBloc({
    required this.uploadClothesPhoto,
    required this.uploadHumanPhoto,
  }) : super(PhotoUploadInitialState()) {
    on<TakePhotoFromCameraEvent>(_onTakePhotoFromCamera);
    on<ChoosePhotoFromGalleryEvent>(_onChoosePhotoFromGallery);
    on<UploadPhotoEvent>(_onUploadPhoto);
  }

  Future<void> _onTakePhotoFromCamera(
    TakePhotoFromCameraEvent event,
    Emitter<PhotoUploadState> emit,
  ) async {
    emit(PhotoUploadLoadingState());
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.camera);
      if (image != null) {
        add(
          UploadPhotoEvent(
            file: File(image.path),
            username: event.username,
            subcategory: event.subcategory,
          ),
        );
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
        add(
          UploadPhotoEvent(
            file: File(image.path),
            username: event.username,
            subcategory: event.subcategory,
          ),
        );
      } else {
        emit(const PhotoUploadFailureState(message: 'No image selected'));
      }
    } catch (e) {
      emit(PhotoUploadFailureState(message: e.toString()));
    }
  }

  Future<void> _onUploadPhoto(
    UploadPhotoEvent event,
    Emitter<PhotoUploadState> emit,
  ) async {
    emit(PhotoUploadLoadingState());
    try {
      final photoEntity =
          event.subcategory != null
              ? await uploadClothesPhoto(
                event.file,
                event.username,
                event.subcategory!,
              )
              : await uploadHumanPhoto(event.file, event.username);
      emit(PhotoUploadSuccessState(photo: photoEntity));
    } catch (e) {
      emit(PhotoUploadFailureState(message: e.toString()));
    }
  }
}
