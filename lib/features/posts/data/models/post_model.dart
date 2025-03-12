import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../../domain/entities/post_entitiy.dart';

class PostModel extends PostEntity {
  const PostModel({
    required super.id,
    required super.userId,
    required super.username,
    required super.avatarUrl,
    required super.imageUrl,
    required super.description,
    required super.tags,
    required super.createdAt,
    required super.likesCount,
    required super.commentsCount,
    required super.isLikedByUser,
  });

  factory PostModel.fromMap(Map<String, dynamic> map) {
    return PostModel(
      id: map['id'] as String,
      userId: map['userId'] as String,
      username: map['username'] as String,
      avatarUrl: map['avatarUrl'] as String,
      imageUrl: map['imageUrl'] as String,
      description: map['description'] as String,
      tags: List<String>.from(map['tags'] as List<dynamic>),
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
      likesCount: map['likesCount'] as int,
      commentsCount: map['commentsCount'] as int,
      isLikedByUser: map['isLikedByUser'] as bool,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'username': username,
      'avatarUrl': avatarUrl,
      'imageUrl': imageUrl,
      'description': description,
      'tags': tags,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'likesCount': likesCount,
      'commentsCount': commentsCount,
      'isLikedByUser': isLikedByUser,
    };
  }

  String toJson() => json.encode(toMap());

  factory PostModel.fromJson(String source) =>
      PostModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PostModel(id: $id, userId: $userId, username: $username, avatarUrl: $avatarUrl, imageUrl: $imageUrl, description: $description, tags: $tags, createdAt: $createdAt, likesCount: $likesCount, commentsCount: $commentsCount, isLikedByUser: $isLikedByUser)';
  }

  @override
  bool operator ==(covariant PostModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.userId == userId &&
        other.username == username &&
        other.avatarUrl == avatarUrl &&
        other.imageUrl == imageUrl &&
        other.description == description &&
        listEquals(other.tags, tags) &&
        other.createdAt == createdAt &&
        other.likesCount == likesCount &&
        other.commentsCount == commentsCount &&
        other.isLikedByUser == isLikedByUser;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        userId.hashCode ^
        username.hashCode ^
        avatarUrl.hashCode ^
        imageUrl.hashCode ^
        description.hashCode ^
        tags.hashCode ^
        createdAt.hashCode ^
        likesCount.hashCode ^
        commentsCount.hashCode ^
        isLikedByUser.hashCode;
  }
}
