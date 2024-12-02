import 'package:chat_app/video_chat/messages_screen.dart';
import 'package:flutter/material.dart';

class VideoChatScreen extends StatefulWidget {
  const VideoChatScreen({super.key});

  @override
  State<VideoChatScreen> createState() => _VideoChatScreenState();
}

class _VideoChatScreenState extends State<VideoChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Video & Text Chat'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Column(
        children: [
          // Video Chat Area
          Expanded(
            flex: 3,
            child: Container(
              color: Colors.black,
              child: const Center(
                child: Text(
                  'Video Stream Here',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
          ),
          // Text Chat Area
          const Expanded(
            flex: 2,
            child: ChatSection(),
          ),
        ],
      ),
    );
  }
}
