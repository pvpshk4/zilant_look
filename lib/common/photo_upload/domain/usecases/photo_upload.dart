import 'dart:io';
import 'package:zilant_look/common/photo_upload/domain/entities/photo_entity.dart';

import '../../data/repositories/photo_repository_impl.dart';

class UploadPhotoUseCase {
  final PhotoRepositoryImpl _uploadPhotoRepositoryImpl;

  UploadPhotoUseCase(this._uploadPhotoRepositoryImpl);

  Future<PhotoEntity> call(File file) async {
    return await _uploadPhotoRepositoryImpl.uploadPhoto(file);
  }
}
