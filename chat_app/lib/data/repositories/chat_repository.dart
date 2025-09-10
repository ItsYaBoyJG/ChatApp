import 'package:chat_app/core/services/chat_service.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart';

abstract class ChatRepository {
  Stream<List<Room>> getRooms({bool orderByUpdatedAt = true});
  Stream<List<Message>> getMessages(Room room);
  Stream<List<User>> getUsers();
  Future<void> sendMessage(PartialText message, String roomId);
  Future<Room> createRoom(User otherUser);
  Future<void> updateRoom(Room room);
}

class ChatRepositoryImpl implements ChatRepository {
  final ChatService _chatService;

  ChatRepositoryImpl(this._chatService);

  @override
  Stream<List<Room>> getRooms({bool orderByUpdatedAt = true}) {
    return _chatService.getRooms(orderByUpdatedAt: orderByUpdatedAt);
  }

  @override
  Stream<List<Message>> getMessages(Room room) {
    return _chatService.getMessages(room);
  }

  @override
  Stream<List<User>> getUsers() {
    return _chatService.getUsers();
  }

  @override
  Future<void> sendMessage(PartialText message, String roomId) {
    return _chatService.sendMessage(message, roomId);
  }

  @override
  Future<Room> createRoom(User otherUser) {
    return _chatService.createRoom(otherUser);
  }

  @override
  Future<void> updateRoom(Room room) {
    return _chatService.updateRoom(room);
  }
}