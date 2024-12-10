import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:snapchat_clone/controllers/providers/navbar.dart';
import 'package:snapchat_clone/view/chats/chat_page.dart';
import 'package:snapchat_clone/view/discover/discover.dart';
import 'package:snapchat_clone/view/home/bottom_navbar.dart';

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
    final currentIndex = ref.watch(navBarStateProvider);
    return Scaffold(
        body: IndexedStack(
          index: currentIndex,
          children: [ChatPage(), DiscoverPage()],
        ),
        floatingActionButton: GestureDetector(
          child: Container(
            height: 100.0,
            width: 100.0,
            decoration: BoxDecoration(
              border: Border.all(
                color: const Color.fromARGB(255, 167, 168, 171),
              ),
              borderRadius: BorderRadius.circular(64.0),
              color: const Color.fromARGB(0, 199, 190, 190),
            ),
          ),
          onTap: () {
            //TODO: add camera open function here
            context.push('/camera');
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        bottomNavigationBar: const BottomNavbar());
  }
}
