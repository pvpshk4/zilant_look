import 'package:zilant_look/features/home/domain/entities/home_content_entity.dart';

abstract class HomeRepository {
  Future<HomeContentEntity> getHomeContent();
}
