import 'package:equatable/equatable.dart';

class Message extends Equatable {
  final String id;
  final bool isUser;
  final String message;
  final DateTime createAt;

  const Message({
    required this.isUser,
    required this.message,
    required this.createAt,
    required this.id,
  });

  @override
  List<Object?> get props => [isUser, message, createAt];
}
