import 'dart:io';
import 'package:zilant_look/common/photo_upload/domain/entities/photo_entity.dart';
import '../../data/repositories/photo_repository_impl.dart';

class UploadHumanPhotoUsecase {
  final PhotoRepositoryImpl _uploadPhotoRepositoryImpl;

  UploadHumanPhotoUsecase(this._uploadPhotoRepositoryImpl);

  Future<PhotoEntity> call(File file, String username) async {
    return await _uploadPhotoRepositoryImpl.uploadHumanPhoto(file, username);
  }
}
