import 'package:chat_app/models/message/message_model.dart';

class User {
  final String username;
  final int friendStreak;
  final List<Message> messages;
  final String avatar;

  User({
    required this.username,
    required this.friendStreak,
    required this.messages,
    required this.avatar,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    var messagesFromJson = json['messages'] as List;
    List<Message> messageList =
        messagesFromJson.map((i) => Message.fromJson(i)).toList();

    return User(
      username: json['username'],
      friendStreak: json['friend_streak'],
      messages: messageList,
      avatar: json['avatar'],
    );
  }
}
