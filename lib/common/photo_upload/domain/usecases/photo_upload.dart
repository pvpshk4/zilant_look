import 'package:zilant_look/common/photo_upload/domain/entities/photo_entity.dart';
import 'package:zilant_look/common/photo_upload/domain/repositories/photo_repository.dart';

class UploadPhotoUseCase {
  final PhotoRepository repository;

  UploadPhotoUseCase({required this.repository});

  Future<PhotoEntity> call(String filePath) async {
    return await repository.uploadPhoto(filePath);
  }
}
