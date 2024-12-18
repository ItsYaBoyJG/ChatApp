import 'package:chat_app/controllers/providers/auth.dart';
import 'package:chat_app/utils/splash_screen.dart';
import 'package:chat_app/view/auth/onboarding.dart';
import 'package:chat_app/view/chats/friends/friends_list.dart';
import 'package:chat_app/view/home/home_page.dart';
import 'package:chat_app/view/camera/camera.dart';
import 'package:chat_app/view/chats/chat_page.dart';
import 'package:chat_app/view/discover/discover.dart';
import 'package:chat_app/view/chats/messages/messages_view.dart';
import 'package:chat_app/view/profile/friends_list/selected.dart';
import 'package:chat_app/view/profile/profile_page.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final routerProvider = Provider(
  (ref) {
    final authState = ref.watch(userAuthStateProvider);
    return GoRouter(
      routes: [
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
/*  GoRoute(
    path: '/videochat',
    builder: (context, state) {
      return const VideoChatScreen();
    },
  ), */
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
          name: 'messages',
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
            return const FriendsList();
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
        GoRoute(
          path: '/splash',
          builder: (context, state) {
            return const SplashScreen();
          },
        ),
        GoRoute(
          path: '/onboarding',
          builder: (context, state) {
            return const OnboardingPage();
          },
        ),
      ],
      redirect: (context, state) {
        final isAuth = authState.valueOrNull != null;
        final bool isLogin = state.matchedLocation == '/onboarding';
        final bool isSplash = state.matchedLocation == '/splash';

        if (authState.isLoading || authState.hasError) {
          return null;
        }

        if (isSplash) {
          return isAuth ? '/' : '/onboarding';
        }

        if (isLogin) {
          return isAuth ? '/' : null;
        }

        return isAuth ? null : '/splash';
      },
    );
  },
);
