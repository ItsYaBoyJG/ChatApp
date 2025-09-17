import 'package:chat_app/core/providers/chat_providers.dart';
import 'package:chat_app/core/providers/service_providers.dart';
import 'package:chat_app/core/providers/user_providers.dart';
import 'package:chat_app/view/chats/friends/active_users.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:uuid/uuid.dart';

class FriendsList extends ConsumerStatefulWidget {
  const FriendsList({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _FriendsListState();
  }
}

class _FriendsListState extends ConsumerState<FriendsList> {
  final Uuid _uuid = const Uuid();

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(authServiceProvider);
    final friendsList = ref.watch(
      userFriendsStreamProvider(user.currentUser!.uid),
    );
    return friendsList.when(
      data: (data) {
        if (data.docs.isNotEmpty) {
          return SizedBox(
            height: MediaQuery.of(context).size.height * 0.50,
            width: MediaQuery.of(context).size.width - 10,
            child: ListView.builder(
              itemCount: data.docs.length,
              itemBuilder: (context, index) {
                final friend = data.docs[index];
                return Card(
                  child: ListTile(
                    leading: Text(
                      '${friend.data()['firstName']} ${friend.data()['lastName']}',
                    ),
                    onTap: () {
                      ref.read(selectedRoomProvider.notifier).state = Room(
                        id: friend.id,
                        type: RoomType.direct,
                        users: [
                          User(id: user.currentUser!.uid),
                          User(id: friend.id),
                        ],
                      );
                      context.push('/messages');
                    },
                  ),
                );
              },
            ),
          );
        } else {
          return Column(
            children: [
              SizedBox(
                height: 75,
                width: MediaQuery.of(context).size.width - 100,
                child: const Center(
                  child: Text(
                    'Your friends list is empty, but you can always start a '
                    'conversation with someone and make a new friend',
                  ),
                ),
              ),
              const ActiveUsers(),
            ],
          );
        }
      },
      error: (error, stackTrace) {
        return Text('error');
      },
      loading: () {
        return Scaffold(
          appBar: AppBar(),
          body: const Center(child: CircularProgressIndicator.adaptive()),
        );
      },
    );
  }
}
