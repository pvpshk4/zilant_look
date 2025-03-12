import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../models/post_model.dart';

abstract class PostRemoteDataSource {
  Future<List<PostModel>> getPosts();
}

class PostRemoteDataSourceImpl implements PostRemoteDataSource {
  final http.Client client;

  PostRemoteDataSourceImpl({required this.client});

  @override
  Future<List<PostModel>> getPosts() async {
    final response = await client.get(
      Uri.parse("https://api.example.com/posts"),
    );

    if (response.statusCode == 200) {
      List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => PostModel.fromMap(json)).toList();
    } else {
      throw Exception("Failed to load posts");
    }
  }
}
