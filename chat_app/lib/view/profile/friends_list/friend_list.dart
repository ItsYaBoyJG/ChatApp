import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:snapchat_clone/models/json/get_chat_data.dart';
import 'package:snapchat_clone/models/user/user_model.dart';

class FriendList extends StatefulWidget {
  const FriendList({super.key});

  @override
  State<FriendList> createState() => _FriendListState();
}

class _FriendListState extends State<FriendList> {
  final GetChatData _getChatData = GetChatData();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Friends'),
      ),
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.80,
            width: MediaQuery.of(context).size.width - 2,
            child: FutureBuilder(
                future: _getChatData.loadUsers(),
                builder: (context, snapshot) {
                  if (snapshot.hasData &&
                      snapshot.connectionState == ConnectionState.done) {
                    return ListView.builder(itemBuilder: (context, index) {
                      User user = snapshot.data![index];
                      return Card(
                          child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.white,
                          backgroundImage: NetworkImage(user.avatar),
                        ),
                        title: Text(
                          user.username,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        trailing: Text(
                          '${user.friendStreak}',
                        ),
                        onTap: () {
                          context.pushNamed('selected', pathParameters: {
                            'name': user.username,
                            'snaps': '200',
                            'following': '400',
                            'image': user.avatar,
                          });
                        },
                      ));
                    });
                  } else if (snapshot.hasError ||
                      snapshot.connectionState == ConnectionState.none) {
                    return const Text(
                        'There are currently no friends in your friends list');
                  } else {
                    return const CircularProgressIndicator();
                  }
                }),
          )
        ],
      ),
    );
  }
}
