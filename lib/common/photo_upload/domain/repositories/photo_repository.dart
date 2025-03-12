import 'package:zilant_look/common/photo_upload/domain/entities/photo_entity.dart';

abstract class PhotoRepository {
  Future<PhotoEntity> uploadPhoto(String filePath);
}
