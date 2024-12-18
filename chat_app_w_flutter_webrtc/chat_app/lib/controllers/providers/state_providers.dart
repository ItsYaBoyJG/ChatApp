import 'package:chat_app/backend/auth/user_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart';

final chatIdProvider = StateProvider((ref) {
  UserAuth userAuth = UserAuth();
  final id = userAuth.getUserId();
  return User(id: userAuth.getUserId());
});

final roomProvider = StateProvider(
    (ref) => const Room(id: '', type: RoomType.direct, users: []));

final roomIdProvider = StateProvider((ref) => Room);
