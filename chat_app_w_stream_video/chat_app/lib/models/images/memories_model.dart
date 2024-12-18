class Memories {
  Memories(
      {required this.url,
      required this.description,
      required this.location,
      required this.timestamp});
  final String url;
  final String description;
  final String location;
  final String timestamp;

  factory Memories.fromJson(Map<String, dynamic> json) {
    return Memories(
        url: json['url'],
        description: json['description'],
        location: json['location'],
        timestamp: json['timestamp']);
  }
}
