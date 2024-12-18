class News {
  News({
    required this.title,
    required this.thumbnail,
    required this.summary,
    required this.content,
  });

  final String title;
  final String thumbnail;
  final String summary;
  final String content;

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
        title: json['title'],
        thumbnail: json['thumbnail'],
        summary: json['summary'],
        content: json['content']);
  }
}
