import 'package:chat_app/core/providers/auth_providers.dart';
import 'package:chat_app/core/providers/service_providers.dart';
import 'package:chat_app/models/user/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final userProfileProvider = FutureProvider<UserProfile>((ref) async {
  final userId = ref.watch(currentUserIdProvider);
  if (userId == null) throw Exception('User not authenticated');
  
  final userService = ref.watch(userServiceProvider);
  return userService.getUserProfile(userId);
});

final userVideoCredentialsProvider = FutureProvider.family<DocumentSnapshot<Map<String, dynamic>>, String>((ref, userId) {
  final userService = ref.watch(userServiceProvider);
  return userService.getUserVideoCredentials(userId);
});

final userFriendsStreamProvider = StreamProvider.family<QuerySnapshot<Map<String, dynamic>>, String>((ref, userId) {
  final userService = ref.watch(userServiceProvider);
  return userService.getUserFriendsStream(userId);
});

final publicUsersProvider = FutureProvider<QuerySnapshot<Map<String, dynamic>>>((ref) {
  final userService = ref.watch(userServiceProvider);
  return userService.getPublicUsers();
});