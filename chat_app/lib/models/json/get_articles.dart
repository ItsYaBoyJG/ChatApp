import 'dart:convert';

import 'package:chat_app/models/news/news_model.dart';
import 'package:flutter/services.dart';

class GetArticles {
  final _filepath = 'assets/json/news_articles.json';

  Future<List<News>> loadArticles() async {
    final String response = await rootBundle.loadString(_filepath);
    final data = json.decode(response);
    var articlesFromJson = data['articles'] as List;
    return articlesFromJson
        .map((articlesFromJson) => News.fromJson(articlesFromJson))
        .toList();
  }
}
