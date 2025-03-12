// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class PhotoEntity extends Equatable {
  final String id;
  final String filePath;
  final DateTime createdAt;
  const PhotoEntity({
    required this.id,
    required this.filePath,
    required this.createdAt,
  });

  PhotoEntity copyWith({String? id, String? filePath, DateTime? createdAt}) {
    return PhotoEntity(
      id: id ?? this.id,
      filePath: filePath ?? this.filePath,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  List<Object> get props => [id, filePath, createdAt];
}
