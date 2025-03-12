import 'package:http/http.dart' as http;
import 'package:zilant_look/features/posts/data/models/commet_model.dart';
import 'dart:convert';

abstract class CommentRemoteDataSource {
  Future<List<CommentModel>> getCommentsByPostId(String postId);
}

class CommentRemoteDataSourceImpl implements CommentRemoteDataSource {
  final http.Client client;

  CommentRemoteDataSourceImpl({required this.client});

  @override
  Future<List<CommentModel>> getCommentsByPostId(String postId) async {
    final response = await client.get(
      Uri.parse('https://api.example.com/posts/$postId/comments'),
    );

    if (response.statusCode == 200) {
      List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => CommentModel.fromMap(json)).toList();
    } else {
      throw Exception("Failed to load comments");
    }
  }
}
