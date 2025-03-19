import 'package:zilant_look/features/home/data/repositories/home_repository_impl.dart';
import 'package:zilant_look/features/home/domain/entities/home_content_entity.dart';

class GetHomeContentUseCase {
  final HomeRepositoryImpl _homeRepositoryImpl;

  GetHomeContentUseCase(this._homeRepositoryImpl);

  Future<HomeContentEntity> call() async {
    return await _homeRepositoryImpl.getHomeContent();
  }
}
