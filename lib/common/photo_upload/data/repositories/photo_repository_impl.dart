import 'dart:io';
import 'package:zilant_look/common/photo_upload/domain/entities/photo_entity.dart';
import '../../domain/repositories/photo_repository.dart';
import '../data_sources/remote/photo_remote_data_source.dart';

class PhotoRepositoryImpl implements PhotoRepository {
  final PhotoRemoteDataSourceImpl remoteDataSource;

  PhotoRepositoryImpl(this.remoteDataSource);

  @override
  Future<PhotoEntity> uploadPhoto(
    File file,
    String username,
    String subcategory,
  ) async {
    final photo = await remoteDataSource.uploadPhoto(
      file,
      username,
      subcategory,
    );
    return photo;
  }
}
