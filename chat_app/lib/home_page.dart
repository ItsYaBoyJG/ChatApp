import 'package:chat_app/button.dart';
import 'package:chat_app/call_history.dart';
import 'package:chat_app/chats/chat_notification_list.dart';
import 'package:chat_app/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends ConsumerState<HomePage> {
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
      ),
    );
  }
}
