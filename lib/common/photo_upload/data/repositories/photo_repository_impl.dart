import 'package:zilant_look/common/photo_upload/domain/entities/photo_entity.dart';

import '../../domain/repositories/photo_repository.dart';
import '../data_sources/remote/photo_remote_data_source.dart';

class PhotoRepositoryImpl implements PhotoRepository {
  final PhotoRemoteDataSource remoteDataSource;

  PhotoRepositoryImpl({required this.remoteDataSource});

  @override
  Future<PhotoEntity> uploadPhoto(String filePath) async {
    final photo = await remoteDataSource.uploadPhoto(filePath);
    return photo;
  }
}
