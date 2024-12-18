import 'package:chat_app/routes.dart';
import 'package:chat_app/utils/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class VideoTextChatApp extends ConsumerWidget {
  const VideoTextChatApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    return MaterialApp.router(
      routerConfig: router,
      theme: AppTheme.appTheme,
    );
  }
}
