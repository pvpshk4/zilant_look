import 'package:zilant_look/features/posts/domain/entities/user_entitiy.dart';

abstract class UserRepository {
  Future<List<UserEntity>> getUserByUsername(String username);
}
