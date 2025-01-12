import 'package:chat_app/backend/streams.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final userGroupsStreamProvider = StreamProvider.autoDispose((ref) {
  return FirebaseChatCore.instance.rooms(orderByUpdatedAt: true);
});

final selectedGroupThreadMessagesProvider =
    StreamProvider.autoDispose.family((ref, Room room) {
  return FirebaseChatCore.instance.messages(room);
});

final userFriendsListStreamProvider =
    StreamProvider.autoDispose.family((ref, String id) {
  DbStreams dbStreams = DbStreams();
  return dbStreams.userFriendsStream(id);
});

final availableUsersProvider = StreamProvider.autoDispose((ref) {
  return FirebaseChatCore.instance.users();
});


/*
Make sure updatedAt exists on all rooms
Write a Cloud Function which will update updatedAt of the room when the room changes or new messages come in
Create an Index (Firestore Database -> Indexes tab) where collection ID is rooms,
 field indexed are userIds (type Arrays) and updatedAt (type Descending), query scope is Collection.

 */