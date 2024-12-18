class ReceivedNotification {
  ReceivedNotification(
      {required this.id,
      required this.title,
      required this.body,
      required this.payload,
      this.data});
  final int id;
  final String? title;
  final String? body;
  final String? payload;
  final Map<String, dynamic>? data;
}
