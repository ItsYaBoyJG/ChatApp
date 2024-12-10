import 'package:flutter/material.dart';
import 'package:snapchat_clone/utils/theme/app_theme.dart';

class FABIcon extends StatelessWidget {
  const FABIcon(
      {super.key,
      required this.onPressed,
      required this.icon,
      required this.text});

  final VoidCallback? onPressed;
  final Widget icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Ink(
          decoration: ShapeDecoration(
            color: AppTheme.appTheme.floatingActionButtonTheme.backgroundColor,
            shape: const CircleBorder(),
          ),
          child: IconButton(
            onPressed: onPressed,
            icon: icon,
            color: Colors.white,
          ),
        ),
        Text(text),
      ],
    );
  }
}
