import 'package:flutter/material.dart';
import 'package:snapchat_clone/controllers/providers/user.dart';
import 'package:snapchat_clone/models/message/message_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MessagesView extends ConsumerStatefulWidget {
  const MessagesView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _MessagesViewState();
  }
}

class _MessagesViewState extends ConsumerState<MessagesView> {
  @override
  Widget build(BuildContext context) {
    final user = ref.read(userModelProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(user.username),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 40,
              backgroundImage: NetworkImage(user.avatar),
            ),
            const SizedBox(height: 16),
            Text(
              'Friend Streak: ${user.friendStreak}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 16),
            const Text(
              'Messages:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: user.messages.length,
                itemBuilder: (context, index) {
                  Message message = user.messages[index];

                  //             for (var i = 0; i < user.messages.length; i++) {

                  //     }

                  return Column(
                    children: [
                      //       Text(message.)
                      ListTile(
                        leading: Text(message.text),
                        trailing: Text(
                            '${message.timestamp.month}/${message.timestamp.day}/${message.timestamp.year}'),
                      ),
                      Divider(
                        color: Colors.black,
                      )
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
