import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../domain/usecases/upload_clothes_photo_usecase.dart';
import '../../domain/usecases/upload_human_photo_usecase.dart';
import 'package:zilant_look/common/photo_upload/presentation/bloc/photo_upload_event.dart';
import 'package:zilant_look/common/photo_upload/presentation/bloc/photo_upload_state.dart';
import 'package:zilant_look/common/photo_upload/test_values_config.dart'; //Тестовые значения

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
            username: _getTestValue(
              event.username,
              TestValuesConfig.testUsername,
            ),
            category: _getTestValue(
              event.category,
              TestValuesConfig.testCategory,
            ),
            subcategory: _getTestValue(
              event.subcategory,
              TestValuesConfig.testSubcategory,
            ),
            sub_subcategory: _getTestValue(
              event.sub_subcategory,
              TestValuesConfig.testSubSubcategory,
            ),
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
            username: _getTestValue(
              event.username,
              TestValuesConfig.testUsername,
            ),
            category: _getTestValue(
              event.category,
              TestValuesConfig.testCategory,
            ),
            subcategory: _getTestValue(
              event.subcategory,
              TestValuesConfig.testSubcategory,
            ),
            sub_subcategory: _getTestValue(
              event.sub_subcategory,
              TestValuesConfig.testSubSubcategory,
            ),
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
      if (event.category == null) {
        emit(PhotoUploadFailureState(message: 'Category is required'));
      }
      if (event.subcategory == null) {
        emit(PhotoUploadFailureState(message: 'Subcategory is required'));
        return;
      }

      if (event.sub_subcategory == null) {
        emit(PhotoUploadFailureState(message: 'Sub-subcategory is required'));
        return;
      }

      final photoEntity = await uploadClothesPhoto(
        event.file,
        _getTestValue(event.username, TestValuesConfig.testUsername),
        _getTestValue(event.category, TestValuesConfig.testCategory),
        _getTestValue(event.subcategory, TestValuesConfig.testSubcategory),
        _getTestValue(
          event.sub_subcategory,
          TestValuesConfig.testSubSubcategory,
        ),
      );

      emit(PhotoUploadSuccessState(photo: photoEntity));
    } catch (e) {
      emit(PhotoUploadFailureState(message: e.toString()));
    }
  }

  // Метод для получения тестового значения
  String _getTestValue(String? value, String testValue) {
    return TestValuesConfig.useTestValues && (value == null || value.isEmpty)
        ? testValue
        : value!;
  }
}
