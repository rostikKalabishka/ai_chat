import 'package:chat_repository/chat_repository.dart';
import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String username;
  final String email;
  final String id;
  final String userImage;
  final List<ChatModel> chatList;
  const UserModel(
      {required this.username,
      required this.email,
      required this.id,
      required this.userImage,
      required this.chatList});

  static const emptyUser =
      UserModel(email: '', username: '', id: '', userImage: '', chatList: []);

  @override
  List<Object?> get props => [username, email, id, userImage, chatList];

  UserModel copyWith({
    String? username,
    String? email,
    String? id,
    String? userImage,
    List<ChatModel>? chatList,
  }) {
    return UserModel(
      username: username ?? this.username,
      email: email ?? this.email,
      id: id ?? this.id,
      userImage: userImage ?? this.userImage,
      chatList: chatList ?? this.chatList,
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'username': username,
        'userImage': userImage,
        'email': email,
        'chatList': chatList.map((chat) => chat.toJson()),
      };

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
      username: json['username'],
      email: json['email'],
      id: json['id'],
      userImage: json['userImage'],
      chatList: (json['chatList'] as List<dynamic>)
          .map((e) => ChatModel.fromJson(e as Map<String, dynamic>))
          .toList());
}
