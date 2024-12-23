import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String username;
  final String email;
  final String id;
  final String userImage;

  const UserModel({
    required this.username,
    required this.email,
    required this.id,
    required this.userImage,
  });

  static const emptyUser = UserModel(
    email: '',
    username: '',
    id: '',
    userImage: '',
  );

  @override
  List<Object?> get props => [
        username,
        email,
        id,
        userImage,
      ];

  UserModel copyWith({
    String? username,
    String? email,
    String? id,
    String? userImage,
  }) {
    return UserModel(
      username: username ?? this.username,
      email: email ?? this.email,
      id: id ?? this.id,
      userImage: userImage ?? this.userImage,
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'username': username,
        'userImage': userImage,
        'email': email,
      };

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        username: json['username'],
        email: json['email'],
        id: json['id'],
        userImage: json['userImage'],
      );
}
