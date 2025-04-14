class Message {
  Message({required this.text, required this.sentAt, required this.sentByUid});

  final String text;
  final DateTime sentAt;
  final String sentByUid;

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
        text: json['text'],
        sentAt: json['sentAt'],
        sentByUid: json['sentByUid']);
  }

  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'sentAt': sentAt,
      'sentByUid': sentByUid,
    };
  }
}
