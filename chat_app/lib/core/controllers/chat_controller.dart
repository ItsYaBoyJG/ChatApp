import 'package:chat_app/core/providers/service_providers.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ChatController {
  final Ref ref;

  ChatController(this.ref);

  Future<void> sendMessage(PartialText message, String roomId) async {
    final chatService = ref.read(chatServiceProvider);
    await chatService.sendMessage(message, roomId);
  }

  Future<Room> createRoom(User otherUser) async {
    final chatService = ref.read(chatServiceProvider);
    return await chatService.createRoom(otherUser);
  }

  Future<void> updateRoom(Room room) async {
    final chatService = ref.read(chatServiceProvider);
    await chatService.updateRoom(room);
  }

  Future<void> addFriend(String userId, User user) async {
    final userService = ref.read(userServiceProvider);
    await userService.addUserToFriendsList(userId, user);
  }
}

final chatControllerProvider = Provider<ChatController>((ref) {
  return ChatController(ref);
});