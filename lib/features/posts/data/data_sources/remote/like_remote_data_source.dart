import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../models/like_model.dart';

abstract class LikeRemoteDataSource {
  Future<LikeModel> getLikesCountByPostId(String postId);
  Future<void> addLike(String postId);
}

class LikeRemoteDataSourceImpl implements LikeRemoteDataSource {
  final http.Client client;

  LikeRemoteDataSourceImpl({required this.client});

  @override
  Future<LikeModel> getLikesCountByPostId(String postId) async {
    final response = await client.get(
      Uri.parse('https://api.example.com/posts/$postId/likes'),
    );

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      return LikeModel.fromMap(jsonData);
    } else {
      throw Exception('Failed to load likes count');
    }
  }

  @override
  Future<void> addLike(String postId) async {
    final response = await client.post(
      Uri.parse('https://api.example.com/posts/$postId/likes'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'postId': postId}),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to add like');
    }
  }
}
