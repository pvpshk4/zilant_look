// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class CategoryEntity extends Equatable {
  final String id;
  final String name;
  const CategoryEntity({required this.id, required this.name});

  CategoryEntity copyWith({String? id, String? name}) {
    return CategoryEntity(id: id ?? this.id, name: name ?? this.name);
  }

  @override
  List<Object> get props => [id, name];
}
