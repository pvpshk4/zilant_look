import 'dart:convert';

import 'package:zilant_look/common/domain/entities/clothing_item_entity.dart';

class ClothingItemModel extends ClothingItemEntity {
  const ClothingItemModel({
    required super.id,
    required super.name,
    required super.imageUrl,
    required super.category,
  });
  factory ClothingItemModel.fromMap(Map<String, dynamic> map) {
    return ClothingItemModel(
      id: map['id'] as String,
      name: map['name'] as String,
      imageUrl: map['imageUrl'] as String,
      category: map['category'] as String,
    );
  }
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
      'category': category,
    };
  }

  String toJson() => json.encode(toMap());

  factory ClothingItemModel.fromJson(String source) =>
      ClothingItemModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;
}

extension ClothingItemModelExtension on ClothingItemModel {
  ClothingItemEntity toEntity() {
    return ClothingItemEntity(
      id: id,
      name: name,
      imageUrl: imageUrl,
      category: category,
    );
  }
}

extension ClothingItemEntityExtension on ClothingItemEntity {
  ClothingItemModel toModel() {
    return ClothingItemModel(
      id: id,
      name: name,
      imageUrl: imageUrl,
      category: category,
    );
  }
}
