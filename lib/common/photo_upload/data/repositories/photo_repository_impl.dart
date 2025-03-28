import 'dart:io';
import 'package:zilant_look/common/photo_upload/domain/entities/photo_entity.dart';
import '../../domain/repositories/photo_repository.dart';
import '../data_sources/remote/photo_remote_data_source.dart';

class PhotoRepositoryImpl implements PhotoRepository {
  final PhotoRemoteDataSourceImpl remoteDataSource;

  PhotoRepositoryImpl(this.remoteDataSource);

  @override
  Future<PhotoEntity> uploadClothesPhoto(
    File file,
    String username,
    String category,
    String subcategory,
    String sub_subcategory,
  ) async {
    final photo = await remoteDataSource.uploadClothesPhoto(
      file,
      username,
      category,
      subcategory,
      sub_subcategory,
    );
    return photo;
  }

  @override
  Future<PhotoEntity> uploadHumanPhoto(File file, String username) async {
    final photo = await remoteDataSource.uploadHumanPhoto(file, username);
    return photo;
  }
}
