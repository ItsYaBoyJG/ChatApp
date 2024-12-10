import 'package:flutter/material.dart';
import 'package:snapchat_clone/models/json/get_chat_data.dart';
import 'package:snapchat_clone/models/user/user_model.dart';

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
          FutureBuilder(
              future: _getChatData.loadUsers(),
              builder: (context, snapshot) {
                if (snapshot.hasData &&
                    snapshot.connectionState == ConnectionState.done) {
                  return SizedBox(
                    height: MediaQuery.of(context).size.height * 0.142,
                    width: double.infinity,
                    child: ListView.builder(
                      physics: const AlwaysScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int index) {
                        User user = snapshot.data![index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Column(
                            children: [
                              Container(
                                width: 75.0,
                                height: 75.0,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.blue, width: 2.5),
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(user.avatar)),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(60.0)),
                                  color: Colors.black12,
                                ),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.004,
                              ),
                              Text(user.username)
                            ],
                          ),
                        );
                      },
                    ),
                  );
                } else if (snapshot.connectionState == ConnectionState.none ||
                    snapshot.data == null) {
                  return Center(
                    child: Text('error'),
                  );
                }
                return const CircularProgressIndicator();
              })
        ],
      ),
    );
  }
}
