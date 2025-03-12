import 'package:zilant_look/features/posts/data/data_sources/remote/user_remote_data_source.dart';
import 'package:zilant_look/features/posts/domain/entities/user_entitiy.dart';

import '../../domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource remoteDataSource;

  UserRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<UserEntity>> getUserByUsername(String username) async {
    final users = await remoteDataSource.getUserByUsername(username);
    return users;
  }
}
