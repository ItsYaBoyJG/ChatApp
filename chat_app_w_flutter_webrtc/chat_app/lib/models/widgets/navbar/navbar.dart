import 'package:chat_app/utils/theme/app_theme.dart';
import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  const NavBar(
      {super.key,
      required this.currentIndex,
      required this.onTap,
      required this.items});

  final int currentIndex;
  final List<BottomNavigationBarItem> items;
  final void Function(int) onTap;
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor:
          AppTheme.appTheme.bottomNavigationBarTheme.backgroundColor,
      currentIndex: currentIndex,
      onTap: onTap,
      items: items,
    );
  }
}
