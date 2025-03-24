import 'package:http/http.dart' as http;
import 'package:zilant_look/common/data/models/clothing_item_model.dart';
import 'dart:convert';

abstract class WardrobeRemoteDataSource {
  Future<List<ClothingItemModel>> getWardrobeItems();
  Future<List<ClothingItemModel>> filterWardrobeByCategory(String category);
  Future<void> addClothingItem(ClothingItemModel item);
  Future<void> deleteClothingItem(String id);
  Future<void> updateClothingItem(ClothingItemModel item);
}

class WardrobeRemoteDataSourceImpl implements WardrobeRemoteDataSource {
  final http.Client client;

  WardrobeRemoteDataSourceImpl(this.client);

  @override
  Future<List<ClothingItemModel>> getWardrobeItems() async {
    final response = await client.get(
      Uri.parse('https://api.example.com/wardrobe'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => ClothingItemModel.fromJson(json)).toList();
    } else {
      throw Exception("Failed to load wardrobe");
    }
  }

  @override
  Future<List<ClothingItemModel>> filterWardrobeByCategory(
    String category,
  ) async {
    final response = await client.get(
      Uri.parse('https://api.example.com/wardrobe?category=$category'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => ClothingItemModel.fromJson(json)).toList();
    } else {
      throw Exception("Failed to filter wardrobe by category");
    }
  }

  @override
  Future<void> addClothingItem(ClothingItemModel item) async {
    final response = await client.post(
      Uri.parse('https://api.example.com/wardrobe'),
      body: json.encode(item.toJson()),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode != 201) {
      throw Exception("Failed to add item");
    }
  }

  @override
  Future<void> deleteClothingItem(String id) async {
    final response = await client.delete(
      Uri.parse('https://api.example.com/wardrobe/$id'),
    );

    if (response.statusCode != 200) {
      throw Exception("Failed to delete item");
    }
  }

  @override
  Future<void> updateClothingItem(ClothingItemModel item) async {
    final response = await client.put(
      Uri.parse('https://api.example.com/wardrobe/${item.id}'),
      body: json.encode(item.toJson()),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode != 200) {
      throw Exception("Failed to update item");
    }
  }
}
