import 'package:chat_app/theme.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  const AppButton({super.key, required this.onPressed, required this.text});

  final void Function() onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
            backgroundColor: WidgetStateProperty.resolveWith((states) {
          return states.contains(WidgetState.pressed)
              ? AppTheme.appTheme.colorScheme.onSecondary
              : AppTheme.appTheme.colorScheme.secondary;
        })),
        child: Text(text));
  }
}
