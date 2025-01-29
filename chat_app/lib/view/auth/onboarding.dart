import 'package:chat_app/view/auth/forgot_password.dart';
import 'package:chat_app/view/auth/login.dart';
import 'package:chat_app/view/auth/register.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(
            height: 70,
          ),
          // const WelcomeDisplay(),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: ElevatedButton(
                onPressed: () async {
                  await showModalBottomSheet(
                      isScrollControlled: true,
                      showDragHandle: true,
                      isDismissible: true,
                      context: context,
                      builder: (context) {
                        return const LoginPage();
                      });
                },
                child: const Text('Sign in')),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: ElevatedButton(
                onPressed: () async {
                  await showModalBottomSheet(
                      isScrollControlled: true,
                      showDragHandle: true,
                      isDismissible: true,
                      context: context,
                      builder: (context) {
                        return const RegistrationPage();
                      });
                },
                child: const Text('Register')),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: ElevatedButton(
                onPressed: () async {
                  await showModalBottomSheet(
                      isScrollControlled: true,
                      showDragHandle: true,
                      isDismissible: true,
                      context: context,
                      builder: (context) {
                        return const ResetPasswordPage();
                      });
                },
                child: const Text('Forgot Password')),
          ),
        ],
      ),
    );
  }
}
