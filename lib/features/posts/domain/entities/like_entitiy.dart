import 'package:equatable/equatable.dart';

class LikeEntity extends Equatable {
  final String postId;
  final int likesCount;
  const LikeEntity({required this.postId, required this.likesCount});

  LikeEntity copyWith({String? postId, int? likesCount}) {
    return LikeEntity(
      postId: postId ?? this.postId,
      likesCount: likesCount ?? this.likesCount,
    );
  }

  @override
  List<Object?> get props => [postId, likesCount];
}
