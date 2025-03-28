// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class PhotoEntity extends Equatable {
  final String id;
  final String imageBase64;
  final DateTime createdAt;

  const PhotoEntity({
    required this.id,
    required this.imageBase64,
    required this.createdAt,
  });

  PhotoEntity copyWith({String? id, String? imageBase64, DateTime? createdAt}) {
    return PhotoEntity(
      id: id ?? this.id,
      imageBase64: imageBase64 ?? this.imageBase64,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  List<Object> get props => [id, imageBase64, createdAt];
}
