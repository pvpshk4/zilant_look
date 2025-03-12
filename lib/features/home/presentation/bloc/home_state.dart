import 'package:zilant_look/features/home/domain/entities/home_content_entity.dart';

abstract class HomeState {}

class HomeInitialState extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeLoadedState extends HomeState {
  final HomeContentEntity content;

  HomeLoadedState(this.content);
}

class HomeErrorState extends HomeState {
  final String message;

  HomeErrorState(this.message);
}
