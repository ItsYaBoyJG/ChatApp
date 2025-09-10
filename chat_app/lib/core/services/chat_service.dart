import 'package:flutter_chat_types/flutter_chat_types.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';

abstract class ChatService {
  Stream<List<Room>> getRooms({bool orderByUpdatedAt = true});
  Stream<List<Message>> getMessages(Room room);
  Stream<List<User>> getUsers();
  Future<void> sendMessage(PartialText message, String roomId);
  Future<Room> createRoom(User otherUser);
  Future<void> updateRoom(Room room);
}

class FirebaseChatService implements ChatService {
  @override
  Stream<List<Room>> getRooms({bool orderByUpdatedAt = true}) {
    return FirebaseChatCore.instance.rooms(orderByUpdatedAt: orderByUpdatedAt);
  }

  @override
  Stream<List<Message>> getMessages(Room room) {
    return FirebaseChatCore.instance.messages(room);
  }

  @override
  Stream<List<User>> getUsers() {
    return FirebaseChatCore.instance.users();
  }

  @override
  Future<void> sendMessage(PartialText message, String roomId) async {
    FirebaseChatCore.instance.sendMessage(message, roomId);
  }

  @override
  Future<Room> createRoom(User otherUser) {
    return FirebaseChatCore.instance.createRoom(otherUser);
  }

  @override
  Future<void> updateRoom(Room room) async {
    FirebaseChatCore.instance.updateRoom(room);
  }
}