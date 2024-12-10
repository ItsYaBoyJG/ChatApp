import 'package:flutter/material.dart';
import 'package:snapchat_clone/view/discover/widgets/for_you_tile.dart';
import 'package:snapchat_clone/view/discover/widgets/story_tile.dart';
import 'package:snapchat_clone/view/discover/widgets/sub_tile.dart';
import 'package:snapchat_clone/view/profile/avatar/avatar.dart';

class DiscoverPage extends StatefulWidget {
  const DiscoverPage({super.key});

  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('Discover'),
          actions: const [ProfileAvatar()],
        ),
        body: Stack(
          children: [
            ListView(
              physics: const ClampingScrollPhysics(),
              shrinkWrap: true,
              children: const [
                SubTile(),
                Divider(
                  color: Colors.black,
                ),
                ForYouTile(),
                Divider(
                  color: Colors.black,
                ),
                StoryTile(),
                Divider(
                  color: Colors.black,
                ),
                SizedBox(
                  height: 70,
                )
              ],
            ),
          ],
        ));
  }
}
