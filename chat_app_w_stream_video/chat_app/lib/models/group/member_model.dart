class MemberModel {
  MemberModel(
      {required this.userName, required this.first, required this.last});

  final String userName;
  final String first;
  final String last;

  factory MemberModel.fromJson(Map<String, dynamic> json) {
    return MemberModel(
        userName: json['userName'], first: json['firs'], last: json['last']);
  }
}
