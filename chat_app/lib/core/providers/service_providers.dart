import 'package:chat_app/core/services/auth_service.dart';
import 'package:chat_app/core/services/chat_service.dart';
import 'package:chat_app/core/services/user_service.dart';
import 'package:chat_app/core/services/video_service.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final authServiceProvider = Provider<AuthService>((ref) {
  return FirebaseAuthService();
});

final userServiceProvider = Provider<UserService>((ref) {
  return FirestoreUserService();
});

final chatServiceProvider = Provider<ChatService>((ref) {
  return FirebaseChatService();
});

final videoServiceProvider = Provider<VideoService>((ref) {
  return StreamVideoService();
});