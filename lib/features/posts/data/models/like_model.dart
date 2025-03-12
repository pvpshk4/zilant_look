import 'dart:convert';

import '../../domain/entities/like_entitiy.dart';

class LikeModel extends LikeEntity {
  const LikeModel({required super.postId, required super.likesCount});

  Map<String, dynamic> toMap() {
    return {'postId': postId, 'likesCount': likesCount};
  }

  factory LikeModel.fromMap(Map<String, dynamic> map) {
    return LikeModel(
      postId: map['postId'] as String,
      likesCount: map['likesCount'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory LikeModel.fromJson(String source) =>
      LikeModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
