import 'package:chat_app/models/user/user_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final userModelProvider = StateProvider((ref) {
  return User(username: '', friendStreak: 0, messages: [], avatar: '');
});
