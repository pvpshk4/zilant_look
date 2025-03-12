import 'package:zilant_look/features/home/domain/entities/home_content_entity.dart';
import 'package:zilant_look/features/home/domain/repositories/home_repository.dart';

class GetHomeContent {
  final HomeRepository repository;

  GetHomeContent({required this.repository});

  Future<HomeContentEntity> call() async {
    return await repository.getHomeContent();
  }
}
