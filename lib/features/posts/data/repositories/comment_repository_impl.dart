import '../../domain/entities/comment_entity.dart';
import '../../domain/repositories/comment_repository.dart';
import '../data_sources/remote/comment_remote_data_source.dart';

class CommentRepositoryImpl implements CommentRepository {
  final CommentRemoteDataSource remoteDataSource;

  CommentRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<CommentEntity>> getCommentsByPostId(String postId) async {
    final comments = await remoteDataSource.getCommentsByPostId(postId);
    return comments;
  }
}
