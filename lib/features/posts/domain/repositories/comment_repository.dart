import '../entities/comment_entity.dart';

abstract class CommentRepository {
  Future<List<CommentEntity>> getCommentsByPostId(String postId);
}
