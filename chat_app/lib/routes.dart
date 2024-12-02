import 'package:chat_app/chats/chat_screen.dart';
import 'package:chat_app/home_page.dart';
import 'package:chat_app/video_chat/chat_screen.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(routes: [
  GoRoute(
    path: '/',
    builder: (context, state) {
      return const HomePage();
    },
  ),
  GoRoute(
    path: '/chatthread',
    builder: (context, state) {
      return const ChatThreadsScreen();
    },
  ),
  GoRoute(
    path: '/videochat',
    builder: (context, state) {
      return const VideoChatScreen();
    },
  )
]);
