import 'dart:convert';
import 'package:zilant_look/common/photo_upload/domain/entities/photo_entity.dart';

class PhotoModel extends PhotoEntity {
  const PhotoModel({
    required super.id,
    required super.filePath,
    required super.createdAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'filePath': filePath,
      'createdAt': createdAt.millisecondsSinceEpoch,
    };
  }

  factory PhotoModel.fromMap(Map<String, dynamic> map) {
    return PhotoModel(
      id: map['id'] as String,
      filePath: map['filePath'] as String,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory PhotoModel.fromJson(Map<String, dynamic> json) {
    return PhotoModel.fromMap(json);
  }

  @override
  bool get stringify => true;
}
