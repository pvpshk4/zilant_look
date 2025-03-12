import '../../domain/repositories/like_repository.dart';
import '../data_sources/remote/like_remote_data_source.dart';

class LikeRepositoryImpl implements LikeRepository {
  final LikeRemoteDataSource remoteDataSource;

  LikeRepositoryImpl({required this.remoteDataSource});

  @override
  Future<int> getLikesCountByPostId(String postId) async {
    final like = await remoteDataSource.getLikesCountByPostId(postId);
    return like.likesCount;
  }

  @override
  Future<void> addLike(String postId) async {
    await remoteDataSource.addLike(postId);
  }
}
