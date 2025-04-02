import 'dart:convert';
import 'package:zilant_look/common/photo_upload/domain/entities/photo_entity.dart';

class PhotoModel extends PhotoEntity {
  const PhotoModel({
    required super.user_name,
    required super.image,
    required super.category,
    required super.subcategory,
    required super.sub_subcategory,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'user_name': user_name,
      'image': image,
      'category': category,
      'subcategory': subcategory,
      'sub_subcategory': sub_subcategory,
    };
  }

  factory PhotoModel.fromMap(Map<String, dynamic> map) {
    return PhotoModel(
      user_name: map['user_name'] ?? '',
      image: map['image'] ?? '',
      category: map['category'] ?? '',
      subcategory: map['subcategory'] ?? '',
      sub_subcategory: map['sub_subcategory'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory PhotoModel.fromJson(Map<String, dynamic> json) {
    return PhotoModel(
      user_name: json['user_name'] ?? '',
      image: json['image'] ?? '',
      category: json['category'] ?? '',
      subcategory: json['subcategory'] ?? '',
      sub_subcategory: json['sub_subcategory'] ?? '',
    );
  }
}
