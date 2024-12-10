import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:snapchat_clone/controllers/providers/navbar.dart';
import 'package:snapchat_clone/models/widgets/navbar/navbar.dart';

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
