import 'package:chat_app/backend/user_auth.dart';
import 'package:chat_app/backend/writes.dart';
import 'package:chat_app/providers/auth.dart';
import 'package:chat_app/providers/state_providers.dart';
import 'package:chat_app/providers/stream.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:uuid/uuid.dart';

class MessagesView extends ConsumerStatefulWidget {
  const MessagesView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _MessagesViewState();
  }
}

class _MessagesViewState extends ConsumerState<MessagesView> {
  final DbWrites _dbWrites = DbWrites();

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(chatIdProvider);
    final room = ref.watch(roomProvider);
    final groupThreadMessages =
        ref.watch(selectedGroupThreadMessagesProvider(room));
    return Scaffold(
      appBar: AppBar(
        title: Text('${room.name}'),
      ),
      body: groupThreadMessages.when(
        data: (data) {
          if (data.isNotEmpty) {
            return Chat(
              user: user,
              showUserNames: true,
              messages: data,
              onSendPressed: (text) {
                _dbWrites.addMessageToThread(
                    text,
                    types.Room(
                        id: room.id,
                        type: room.type,
                        users: room.users,
                        updatedAt: DateTime.now().millisecondsSinceEpoch));
              },
              emojiEnlargementBehavior: EmojiEnlargementBehavior.single,
            );
          } else {
            return Chat(
              user: user,
              showUserNames: true,
              messages: const [],
              onSendPressed: (text) {
                _dbWrites.addMessageToThread(text, room);
              },
              emojiEnlargementBehavior: EmojiEnlargementBehavior.single,
            );
          }
        },
        error: (error, stackTrace) {
          print(error);
          print(stackTrace);
          return Text('err');
        },
        loading: () {
          return const CircularProgressIndicator.adaptive();
        },
      ),
    );
  }
}
