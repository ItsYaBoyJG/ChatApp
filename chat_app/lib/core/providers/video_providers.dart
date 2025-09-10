import 'package:chat_app/core/providers/auth_providers.dart';
import 'package:chat_app/core/providers/service_providers.dart';
import 'package:chat_app/models/user/user_video_creds.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final videoCredentialsProvider =
    FutureProvider.family<UserVideoCredentials, String>((ref, userId) {
      final videoService = ref.watch(videoServiceProvider);
      return videoService.getUserVideoCredentials(userId);
    });

final currentUserVideoCredentialsProvider =
    FutureProvider<UserVideoCredentials>((ref) async {
      final userId = ref.watch(currentUserIdProvider);
      if (userId == null) throw Exception('User not authenticated');

      final videoService = ref.watch(videoServiceProvider);
      return videoService.getUserVideoCredentials(userId);
    });
