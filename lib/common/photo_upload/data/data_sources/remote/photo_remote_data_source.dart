import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../models/photo_model.dart';

abstract class PhotoRemoteDataSource {
  Future<PhotoModel> uploadPhoto(String filePath);
}

class PhotoRemoteDataSourceImpl implements PhotoRemoteDataSource {
  final http.Client client;

  PhotoRemoteDataSourceImpl({required this.client});

  @override
  Future<PhotoModel> uploadPhoto(String filePath) async {
    final response = await client.post(
      Uri.parse('https://api.example.com/upload'),
      body: json.encode({'filePath': filePath}),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return PhotoModel.fromMap(jsonData);
    } else {
      throw Exception("Failed to upload photo");
    }
  }
}
