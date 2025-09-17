import 'package:chat_app/data/datasources/json/get_chat_data.dart';
import 'package:flutter/material.dart';

class StoryTile extends StatefulWidget {
  const StoryTile({super.key});

  @override
  State<StoryTile> createState() => _StoryTileState();
}

class _StoryTileState extends State<StoryTile> {
  final GetChatData _getChatData = GetChatData();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Column(
        //crossAxisAlignment: CrossAxisAlignment.start,
        //   mainAxisAlignment: MainAxisAlignment.start,
        //   mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Stories',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
          ),
          Placeholder(),
        ],
      ),
    );
  }
}
