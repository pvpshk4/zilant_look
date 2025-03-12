// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class ClothingItemEntity extends Equatable {
  final String id;
  final String name;
  final String imageUrl;
  final String category;
  const ClothingItemEntity({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.category,
  });

  ClothingItemEntity copyWith({
    String? id,
    String? name,
    String? imageUrl,
    String? category,
  }) {
    return ClothingItemEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
      category: category ?? this.category,
    );
  }

  @override
  List<Object> get props => [id, name, imageUrl, category];
}
