import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ChatPage extends ConsumerStatefulWidget {
  const ChatPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _ChatPageState();
  }
}

class _ChatPageState extends ConsumerState<ChatPage> {
  final GetChatData _getChatData = GetChatData();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Chats'),
          actions: const [ProfileAvatar()],
        ),
        // backgroundColor: Colors.cyan,
        body: FutureBuilder(
            future: _getChatData.loadUsers(),
            builder: (context, snapshot) {
              if (snapshot.hasData &&
                  snapshot.connectionState == ConnectionState.done) {
                return Stack(
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (BuildContext context, int index) {
                        User user = snapshot.data![index];
                        var color = (index % 3 == 0) ? Colors.red : Colors.blue;
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.white,
                            backgroundImage: NetworkImage(user.avatar),
                          ),
                          title: Text(
                            user.username,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Row(
                            children: [
                              Container(
                                width: 10,
                                height: 10,
                                decoration: BoxDecoration(
                                    color: color,
                                    borderRadius: BorderRadius.circular(2)),
                              ),
                              Text('  New snap - 2 min',
                                  style: TextStyle(color: color)),
                            ],
                          ),
                          trailing: Text(
                            '${user.friendStreak}',
                          ),
                          onTap: () {
                            ref.read(userModelProvider.notifier).state = user;
                            context.push('/messages');
                          },
                        );
                      },
                    ),
                  ],
                );
              } else if (snapshot.connectionState == ConnectionState.none ||
                  snapshot.data == null) {
                return Center(
                  child: Text('error'),
                );
              }

              return const CircularProgressIndicator();
            }));
  }
}
