import 'package:zilant_look/features/home/data/models/home_content_model.dart';
import 'package:zilant_look/features/home/domain/repositories/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  @override
  Future<HomeContentModel> getHomeContent() async {
    return HomeContentModel(title: 'Главная', description: 'Добро пожаловать!');
  }
}
