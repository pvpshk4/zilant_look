import '../../domain/entities/post_entitiy.dart';
import '../data_sources/remote/post_remote_data_source.dart';
import '../../domain/repositories/post_repository.dart';

class PostRepositoryImpl implements PostRepository {
  final PostRemoteDataSource remoteDataSource;

  PostRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<PostEntity>> getPosts() async {
    final posts = await remoteDataSource.getPosts();
    return posts;
  }
}
