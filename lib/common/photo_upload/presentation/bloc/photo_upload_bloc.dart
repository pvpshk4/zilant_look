import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../domain/usecases/upload_clothes_photo_usecase.dart';
import '../../domain/usecases/upload_human_photo_usecase.dart';
import 'photo_upload_event.dart';
import 'photo_upload_state.dart';

class PhotoUploadBloc extends Bloc<PhotoUploadEvent, PhotoUploadState> {
  final UploadClothesPhotoUsecase uploadClothesPhoto;
  final UploadHumanPhotoUsecase uploadHumanPhoto;
  final ImagePicker _picker = ImagePicker();

  File? _selectedImage; // Локальное хранилище выбранного фото
  String? _category;
  String? _subcategory;
  String? _subSubcategory;

  PhotoUploadBloc({
    required this.uploadClothesPhoto,
    required this.uploadHumanPhoto,
  }) : super(PhotoUploadInitialState()) {
    on<TakePhotoFromCameraEvent>(_onTakePhotoFromCamera);
    on<ChoosePhotoFromGalleryEvent>(_onChoosePhotoFromGallery);
    on<SelectCategoryEvent>(_onSelectCategory);
    on<SavePhotoEvent>(_onSavePhoto);
    on<CancelPhotoUploadEvent>(_onCancelPhotoUpload);
  }

  Future<void> _onTakePhotoFromCamera(
    TakePhotoFromCameraEvent event,
    Emitter<PhotoUploadState> emit,
  ) async {
    emit(PhotoUploadLoadingState());
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.camera);
      if (image != null) {
        _selectedImage = File(image.path); // Сохраняем выбранный файл локально
        emit(PhotoUploadImageSelectedState(imagePath: _selectedImage!.path));
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
        _selectedImage = File(image.path); // Сохраняем выбранный файл локально
        emit(PhotoUploadImageSelectedState(imagePath: _selectedImage!.path));
      } else {
        emit(const PhotoUploadFailureState(message: 'No image selected'));
      }
    } catch (e) {
      emit(PhotoUploadFailureState(message: e.toString()));
    }
  }

  Future<void> _onSelectCategory(
    SelectCategoryEvent event,
    Emitter<PhotoUploadState> emit,
  ) async {
    _category = event.category;
    _subcategory = event.subcategory;
    _subSubcategory = event.subSubcategory;
    emit(
      CategorySelectionState(
        category: _category!,
        subcategory: _subcategory!,
        subSubcategory: _subSubcategory!,
      ),
    );
  }

  Future<void> _onSavePhoto(
    SavePhotoEvent event,
    Emitter<PhotoUploadState> emit,
  ) async {
    if (_selectedImage == null) {
      emit(const PhotoUploadFailureState(message: 'No image selected'));
      return;
    }

    emit(PhotoUploadLoadingState());
    try {
      if (_category == null) {
        // Загрузка фото человека
        final photoEntity = await uploadHumanPhoto(
          _selectedImage!,
          "default_user", // Можно передать имя пользователя через параметры
        );
        emit(PhotoUploadSuccessState(photo: photoEntity));
      } else {
        // Загрузка фото одежды
        final photoEntity = await uploadClothesPhoto(
          _selectedImage!,
          "default_user", // Можно передать имя пользователя через параметры
          _category!,
          _subcategory!,
          _subSubcategory!,
        );
        emit(PhotoUploadSuccessState(photo: photoEntity));
      }
    } catch (e) {
      emit(PhotoUploadFailureState(message: e.toString()));
    }
  }

  Future<void> _onCancelPhotoUpload(
    CancelPhotoUploadEvent event,
    Emitter<PhotoUploadState> emit,
  ) async {
    _selectedImage = null;
    _category = null;
    _subcategory = null;
    _subSubcategory = null;
    emit(PhotoUploadInitialState());
  }
}
