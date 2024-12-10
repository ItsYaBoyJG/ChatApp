import 'package:chat_app/routes.dart';
import 'package:chat_app/utils/theme/app_theme.dart';
import 'package:flutter/material.dart';

class VideoTextChatApp extends StatelessWidget {
  const VideoTextChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      theme: AppTheme.appTheme,
    );
  }
}
