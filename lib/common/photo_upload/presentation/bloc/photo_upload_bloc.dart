import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:zilant_look/common/photo_upload/domain/entities/photo_entity.dart';
import 'package:zilant_look/common/AppData/presentation/bloc/app_data_bloc.dart';
import 'package:zilant_look/common/AppData/presentation/bloc/app_data_event.dart';
import 'photo_upload_event.dart';
import 'photo_upload_state.dart';
import 'dart:convert';

class PhotoUploadBloc extends Bloc<PhotoUploadEvent, PhotoUploadState> {
  final AppDataBloc _appDataBloc;
  final ImagePicker _picker = ImagePicker();
  bool _isClothesUpload = false;
  File? _selectedImage;
  String? _category;
  String? _subcategory;
  String? _subSubcategory;

  PhotoUploadBloc(this._appDataBloc) : super(PhotoUploadInitialState()) {
    on<SetUploadTypeEvent>(_onSetUploadType);
    on<TakePhotoFromCameraEvent>(_onTakePhotoFromCamera);
    on<ChoosePhotoFromGalleryEvent>(_onChoosePhotoFromGallery);
    on<CancelPhotoUploadEvent>(_onCancelPhotoUpload);
    on<SelectCategoryEvent>(_onSelectCategory);
    on<SavePhotoEvent>(_onSavePhoto);
  }

  Future<void> _onSetUploadType(
    SetUploadTypeEvent event,
    Emitter<PhotoUploadState> emit,
  ) async {
    _isClothesUpload = event.isClothesUpload;
  }

  Future<void> _onTakePhotoFromCamera(
    TakePhotoFromCameraEvent event,
    Emitter<PhotoUploadState> emit,
  ) async {
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.camera);
      if (pickedFile != null) {
        _selectedImage = File(pickedFile.path);
        if (_isClothesUpload) {
          emit(PhotoUploadAwaitingCategoryState(pickedFile.path));
        } else {
          emit(PhotoUploadPreviewState(pickedFile.path));
        }
      }
    } catch (e) {
      emit(PhotoUploadFailureState('Ошибка при съемке фото: $e'));
    }
  }

  Future<void> _onChoosePhotoFromGallery(
    ChoosePhotoFromGalleryEvent event,
    Emitter<PhotoUploadState> emit,
  ) async {
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        _selectedImage = File(pickedFile.path);
        if (_isClothesUpload) {
          emit(PhotoUploadAwaitingCategoryState(pickedFile.path));
        } else {
          emit(PhotoUploadPreviewState(pickedFile.path));
        }
      }
    } catch (e) {
      emit(PhotoUploadFailureState('Ошибка при выборе фото: $e'));
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

  Future<void> _onSelectCategory(
    SelectCategoryEvent event,
    Emitter<PhotoUploadState> emit,
  ) async {
    _category = event.category;
    _subcategory = event.subcategory;
    _subSubcategory = event.subSubcategory;
  }

  Future<void> _onSavePhoto(
    SavePhotoEvent event,
    Emitter<PhotoUploadState> emit,
  ) async {
    if (_selectedImage == null) {
      emit(const PhotoUploadFailureState('Нет выбранного изображения'));
      return;
    }

    emit(PhotoUploadLoadingState());
    try {
      final username = 'test_user';
      final base64Image = base64Encode(await _selectedImage!.readAsBytes());
      if (_isClothesUpload) {
        if (_category == null ||
            _subcategory == null ||
            _subSubcategory == null) {
          emit(const PhotoUploadFailureState('Категории не выбраны'));
          return;
        }
        final photoEntity = PhotoEntity(
          user_name: username,
          image: base64Image,
          category: _category!,
          subcategory: _subcategory!,
          sub_subcategory: _subSubcategory!,
        );
        // Убрали прямой вызов репозитория, оставили только событие
        _appDataBloc.add(
          AddClothingItemEvent(
            fileBase64: photoEntity.image,
            userName: username,
            category: photoEntity.category,
            subcategory: photoEntity.subcategory,
            subSubcategory: photoEntity.sub_subcategory,
          ),
        );
        emit(PhotoUploadSuccessState(photoEntity));
      } else {
        final photoEntity = PhotoEntity(
          user_name: username,
          image: base64Image,
          category: 'full',
          subcategory: '',
          sub_subcategory: '',
        );
        // Убрали прямой вызов репозитория, оставили только событие
        _appDataBloc.add(
          AddHumanPhotoEvent(
            photoBase64: 'data:image/png;base64,${photoEntity.image}',
            userName: username,
          ),
        );
        emit(PhotoUploadSuccessState(photoEntity));
      }
    } catch (e) {
      emit(PhotoUploadFailureState('Ошибка при загрузке фото: $e'));
    }
  }
}
