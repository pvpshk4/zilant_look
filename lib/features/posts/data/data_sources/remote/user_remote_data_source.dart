import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../models/user_model.dart';

abstract class UserRemoteDataSource {
  Future<List<UserModel>> getUserByUsername(String username);
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final http.Client client;

  UserRemoteDataSourceImpl({required this.client});

  @override
  Future<List<UserModel>> getUserByUsername(String username) async {
    final response = await client.get(
      Uri.parse('https://api.example.com/posts'),
    );

    if (response.statusCode == 200) {
      List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => UserModel.fromMap(json)).toList();
    } else {
      throw Exception("Failed to load user");
    }
  }
}
