import 'package:chat_app/controllers/providers/nav.dart';
import 'package:chat_app/models/widgets/navbar/navbar.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class BottomNavbar extends ConsumerStatefulWidget {
  const BottomNavbar({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _BottomNavbarState();
  }
}

class _BottomNavbarState extends ConsumerState<BottomNavbar> {
  @override
  Widget build(BuildContext context) {
    final currentIndex = ref.watch(navBarStateProvider);
    return NavBar(
      items: const [
        BottomNavigationBarItem(label: '', icon: Icon(Icons.video_call)),
        BottomNavigationBarItem(label: '', icon: Icon(Icons.chat)),
        BottomNavigationBarItem(label: '', icon: Icon(Icons.map_outlined)),
        BottomNavigationBarItem(label: '', icon: Icon(Icons.search))
      ],
      currentIndex: currentIndex,
      onTap: (value) {
        ref.read(navBarStateProvider.notifier).state = value;
      },
    );
  }
}
