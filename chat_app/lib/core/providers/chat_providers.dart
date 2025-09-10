import 'package:chat_app/core/providers/service_providers.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final chatRoomsProvider = StreamProvider.autoDispose<List<Room>>((ref) {
  final chatService = ref.watch(chatServiceProvider);
  return chatService.getRooms(orderByUpdatedAt: true);
});

final chatMessagesProvider = StreamProvider.autoDispose.family<List<Message>, Room>((ref, room) {
  final chatService = ref.watch(chatServiceProvider);
  return chatService.getMessages(room);
});

final availableUsersProvider = StreamProvider.autoDispose<List<User>>((ref) {
  final chatService = ref.watch(chatServiceProvider);
  return chatService.getUsers();
});

final selectedRoomProvider = StateProvider<Room?>(
  (ref) => null,
);