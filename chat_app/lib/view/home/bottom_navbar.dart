import 'package:chat_app/controllers/providers/navbar.dart';
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
      items: [
        BottomNavigationBarItem(label: '', icon: Icon(Icons.message)),
        BottomNavigationBarItem(label: '', icon: Icon(Icons.search))
      ],
      currentIndex: currentIndex,
      onTap: (value) {
        ref.read(navBarStateProvider.notifier).state = value;
      },
    );
  }
}
