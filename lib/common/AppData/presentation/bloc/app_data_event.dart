import 'package:equatable/equatable.dart';

abstract class AppDataEvent extends Equatable {
  const AppDataEvent();

  @override
  List<Object?> get props => [];
}

class LoadAppDataEvent extends AppDataEvent {
  const LoadAppDataEvent();
}

class AddHumanPhotoEvent extends AppDataEvent {
  final String photoBase64;
  final String userName;

  const AddHumanPhotoEvent({required this.photoBase64, required this.userName});
}

class AddClothingItemEvent extends AppDataEvent {
  final String fileBase64;
  final String userName;
  final String category;
  final String subcategory;
  final String subSubcategory;

  const AddClothingItemEvent({
    required this.fileBase64,
    required this.userName,
    required this.category,
    required this.subcategory,
    required this.subSubcategory,
  });
}

class ClearAppDataEvent extends AppDataEvent {}
