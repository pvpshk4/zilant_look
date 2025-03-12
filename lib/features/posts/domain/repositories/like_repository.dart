abstract class LikeRepository {
  Future<int> getLikesCountByPostId(String postId);
  Future<void> addLike(String postId);
}
