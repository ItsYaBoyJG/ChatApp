import 'package:flutter/material.dart';
import 'package:snapchat_clone/models/json/get_articles.dart';
import 'package:snapchat_clone/models/news/news_model.dart';

class ForYouTile extends StatefulWidget {
  const ForYouTile({super.key});

  @override
  State<ForYouTile> createState() => _ForYouTileState();
}

class _ForYouTileState extends State<ForYouTile> {
  GetArticles _getArticles = GetArticles();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _getArticles.loadArticles(),
        builder: (context, snapshot) {
          if (snapshot.data != null ||
              snapshot.connectionState == ConnectionState.done) {
            return Padding(
                padding: const EdgeInsets.all(4.0),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.30,
                  width: MediaQuery.of(context).size.width - 2,
                  child: Column(
                    //    crossAxisAlignment: CrossAxisAlignment.start,
                    //   mainAxisAlignment: MainAxisAlignment.start,
                    //   mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'For you',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      //     const SizedBox(
                      //       height: 5,
                      //    ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.26,
                        width: MediaQuery.of(context).size.width,
                        child: GridView.builder(
                            scrollDirection: Axis.horizontal,
                            physics: const AlwaysScrollableScrollPhysics(),
                            shrinkWrap: true,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 1, childAspectRatio: 9 / 7),
                            itemCount: 5,
                            itemBuilder: (context, index) {
                              News news = snapshot.data![index];

                              return Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Stack(
                                  children: [
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.15,
                                      width: MediaQuery.of(context).size.width *
                                          0.6,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: Image.asset(news.thumbnail)
                                                  .image
                                              // NetworkImage('')
                                              ),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(8.0)),
                                          color: Colors.white),
                                    ),
                                    Positioned(
                                      bottom: 2,
                                      child: Padding(
                                        padding: const EdgeInsets.all(3.0),
                                        child: Container(
                                          height: 25,
                                          width: 100,
                                          decoration: const BoxDecoration(
                                              gradient: LinearGradient(
                                                  colors: [
                                                Colors.black,
                                                Colors.transparent
                                              ],
                                                  begin: Alignment.bottomCenter,
                                                  end: Alignment.topCenter)),
                                          child: Padding(
                                            padding: const EdgeInsets.all(2.0),
                                            child: Text(
                                              news.title,
                                              softWrap: true,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }),
                      )
                    ],
                  ),
                ));
          } else if (snapshot.data == null ||
              snapshot.connectionState == ConnectionState.none) {
            print(snapshot.error);
            return Text('error');
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }
          return Text('${snapshot.data!.first}');
        });
  }
}
