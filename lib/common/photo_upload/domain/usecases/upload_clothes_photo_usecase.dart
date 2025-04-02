import 'dart:io';

import 'package:zilant_look/common/photo_upload/domain/entities/photo_entity.dart';
import '../../data/repositories/photo_repository_impl.dart';

class UploadClothesPhotoUsecase {
  final PhotoRepositoryImpl _uploadPhotoRepositoryImpl;

  UploadClothesPhotoUsecase(this._uploadPhotoRepositoryImpl);

  Future<PhotoEntity> call(
    File file, // Используем File
    String username,
    String category,
    String subcategory,
    String sub_subcategory,
  ) async {
    return await _uploadPhotoRepositoryImpl.uploadClothesPhoto(
      file, // Передаем File
      username,
      category,
      subcategory,
      sub_subcategory,
    );
  }
}
