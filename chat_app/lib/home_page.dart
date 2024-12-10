import 'package:chat_app/utils/theme/app_theme.dart';
import 'package:chat_app/view/video_chat/call_history.dart';
import 'package:chat_app/view/chats/chat_notification_list.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.appTheme.colorScheme.primary,
      ),
      body: const Column(
        children: [
          CallHistory(),
          ChatNotificationList(),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: GestureDetector(
        child: Container(
          margin: const EdgeInsets.all(5.0),
          padding: const EdgeInsets.all(10.0),
          height: 70,
          width: MediaQuery.of(context).size.width - 15,
          decoration: BoxDecoration(
              color: AppTheme.appTheme.colorScheme.primary,
              borderRadius: BorderRadius.circular(24.0)),
          child: const Center(
            child: Text(
              ' Make a video call',
              style: TextStyle(fontSize: 20.0),
            ),
          ),
        ),
        onTap: () {},
      ),
    );
  }
}
