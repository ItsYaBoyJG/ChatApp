import 'package:chat_app/home_page.dart';
import 'package:chat_app/view/camera/camera.dart';
import 'package:chat_app/view/chats/chat_page.dart';
import 'package:chat_app/view/discover/discover.dart';
import 'package:chat_app/view/messages/messages_view.dart';
import 'package:chat_app/view/profile/friends_list/friend_list.dart';
import 'package:chat_app/view/profile/friends_list/selected.dart';
import 'package:chat_app/view/profile/profile_page.dart';
import 'package:chat_app/view/video_chat/chat_screen.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(routes: [
  GoRoute(
    path: '/',
    builder: (context, state) {
      return const HomePage();
    },
  ),
  /* GoRoute(
    path: '/chatthread',
    builder: (context, state) {
      return const ChatThreadsScreen();
    },
  ),*/
  GoRoute(
    path: '/videochat',
    builder: (context, state) {
      return const VideoChatScreen();
    },
  ),
  GoRoute(
    path: '/discover',
    builder: (context, state) {
      return const DiscoverPage();
    },
  ),
  GoRoute(
    path: '/camera',
    builder: (context, state) {
      return const CameraDisplay();
    },
  ),
  GoRoute(
    path: '/chat',
    builder: (context, state) {
      return const ChatPage();
    },
  ),
  GoRoute(
    path: '/messages',
    builder: (context, state) {
      return const MessagesView();
    },
  ),
  GoRoute(
    path: '/profile',
    builder: (context, state) {
      return const ProfilePage();
    },
  ),
  GoRoute(
    path: '/friends',
    builder: (context, state) {
      return const FriendList();
    },
  ),
  GoRoute(
    path: '/selected/:name/:snaps/:following/:image',
    name: 'selected',
    builder: (context, state) {
      return SelectedProfile(
        name: state.pathParameters['name']!,
        snaps: state.pathParameters['snaps']!,
        following: state.pathParameters['following']!,
        image: state.pathParameters['image']!,
      );
    },
  ),
]);
