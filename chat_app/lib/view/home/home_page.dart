import 'package:chat_app/backend/user_auth.dart';
import 'package:chat_app/providers/future.dart';
import 'package:chat_app/providers/nav.dart';
import 'package:chat_app/utils/theme/app_theme.dart';
import 'package:chat_app/view/chats/chat_page.dart';
import 'package:chat_app/view/discover/discover.dart';
import 'package:chat_app/view/home/bottom_navbar.dart';
import 'package:chat_app/view/map/map_page.dart';
import 'package:chat_app/view/video_chat/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:stream_video_flutter/stream_video_flutter.dart';

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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentIndex = ref.watch(navBarStateProvider);
    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: const [
          ChatPage(),
          MapPage(),
          VideoChatScreen(),
          DiscoverPage()
        ],
      ),
      bottomNavigationBar: const BottomNavbar(),
    );
  }
}
