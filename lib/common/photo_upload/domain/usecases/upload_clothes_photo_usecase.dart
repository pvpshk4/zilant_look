import 'dart:io';
import 'package:zilant_look/common/photo_upload/domain/entities/photo_entity.dart';
import '../../data/repositories/photo_repository_impl.dart';

class UploadClothesPhotoUsecase {
  final PhotoRepositoryImpl _uploadPhotoRepositoryImpl;

  UploadClothesPhotoUsecase(this._uploadPhotoRepositoryImpl);

  Future<PhotoEntity> call(
    File file,
    String username,
    String subcategory,
  ) async {
    return await _uploadPhotoRepositoryImpl.uploadClothesPhoto(
      file,
      username,
      subcategory,
    );
  }
}
