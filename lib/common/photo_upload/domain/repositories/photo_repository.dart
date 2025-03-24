import 'dart:io';
import '../entities/photo_entity.dart';

abstract class PhotoRepository {
  Future<PhotoEntity> uploadPhoto(File file, String username);
}
