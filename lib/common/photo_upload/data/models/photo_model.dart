import 'dart:convert';
import 'package:zilant_look/common/photo_upload/domain/entities/photo_entity.dart';

class PhotoModel extends PhotoEntity {
  const PhotoModel({
    required super.id,
    required super.imageBase64,
    required super.createdAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'filePath': imageBase64,
      'createdAt': createdAt.millisecondsSinceEpoch,
    };
  }

  factory PhotoModel.fromMap(Map<String, dynamic> map) {
    return PhotoModel(
      id:
          map['status'] == 'success'
              ? 'success'
              : 'error', // Используем статус как ID
      imageBase64: map['image_base64'] ?? '', // Сохраняем Base64-изображение
      createdAt: DateTime.now(),
    );
  }

  String toJson() => json.encode(toMap());

  factory PhotoModel.fromJson(Map<String, dynamic> json) {
    return PhotoModel.fromMap(json);
  }

  @override
  bool get stringify => true;
}
