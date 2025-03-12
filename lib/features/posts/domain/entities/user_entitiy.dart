import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String id;
  final String username;
  final String avatarUrl;
  const UserEntity({
    required this.id,
    required this.username,
    required this.avatarUrl,
  });

  UserEntity copyWith({String? id, String? username, String? avatarUrl}) {
    return UserEntity(
      id: id ?? this.id,
      username: username ?? this.username,
      avatarUrl: avatarUrl ?? this.avatarUrl,
    );
  }

  @override
  List<Object?> get props => [id, username, avatarUrl];
}
