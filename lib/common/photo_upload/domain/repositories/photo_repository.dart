import 'dart:io';
import '../entities/photo_entity.dart';

abstract class PhotoRepository {
  Future<PhotoEntity> uploadClothesPhoto(
    File file,
    String username,
    String category,
    String subcategory,
    String sub_subcategory,
  );

  Future<PhotoEntity> uploadHumanPhoto(File file, String username);
}
