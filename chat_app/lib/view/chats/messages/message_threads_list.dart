import 'package:chat_app/providers/state_providers.dart';
import 'package:chat_app/providers/stream.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MessageThreadsList extends ConsumerStatefulWidget {
  const MessageThreadsList({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _MessageThreadsListState();
  }
}

class _MessageThreadsListState extends ConsumerState<MessageThreadsList> {
  @override
  Widget build(BuildContext context) {
    final messageThreadsList = ref.watch(userGroupsStreamProvider);
    return messageThreadsList.when(data: (data) {
      if (data.isNotEmpty) {
        return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  leading: Text('${data[index].name}'),
                  onTap: () {
                    ref.read(roomProvider.notifier).state = Room(
                        id: data[index].id,
                        type: data[index].type,
                        users: data[index].users);

                    context.push('/messages');
                  },
                ),
              );
            });
      } else {
        return const Padding(
            padding: EdgeInsets.all(18.0),
            child: Center(
              child: Text('You have no messages.'),
            ));
      }
    }, error: (error, stackTrace) {
      print(error);
      print(stackTrace);
      return Text('error $error');
    }, loading: () {
      return const CircularProgressIndicator.adaptive();
    });
  }
}
