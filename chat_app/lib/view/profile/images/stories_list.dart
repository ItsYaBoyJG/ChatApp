import 'package:flutter/material.dart';
import 'package:snapchat_clone/models/images/memories_model.dart';
import 'package:snapchat_clone/models/json/get_memories.dart';

class StoriesList extends StatefulWidget {
  const StoriesList({super.key});

  @override
  State<StoriesList> createState() => _StoriesListState();
}

class _StoriesListState extends State<StoriesList> {
  GetMemories _getMemories = GetMemories();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _getMemories.loadMemories(),
        builder: (context, snapshot) {
          if (snapshot.hasData &&
              snapshot.connectionState == ConnectionState.done) {
            return SizedBox(
              height: MediaQuery.of(context).size.height * 0.35,
              width: MediaQuery.of(context).size.width - 5,
              child: GridView.builder(
                  physics: const ClampingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3, childAspectRatio: 9.9 / 15.7),
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    Memories memories = snapshot.data![index];
                    return Container(
                      height: 150,
                      width: 200,
                      decoration: BoxDecoration(
                          border: Border.all(color: Color(0xff000000)),
                          borderRadius: BorderRadius.circular(6.0),
                          image: DecorationImage(
                              image: Image.asset(memories.url).image)),
                    );
                  }),
            );
          } else if (snapshot.data == null ||
              snapshot.hasError ||
              snapshot.connectionState == ConnectionState.none) {
            return Center(
              child: Text('errore'),
            );
          }
          return const CircularProgressIndicator();
        });
  }
}
