import 'package:chat_app/models/group/group_model.dart';

class UserProfile {
  UserProfile(
      {required this.userName,
      required this.first,
      required this.last,
      required this.groups});

  final String userName;
  final String first;
  final String last;
  final List groups;

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    var groupsFromJson = json['messages'] as List;
    List groupList = groupsFromJson.map((i) => GroupModel.fromJson(i)).toList();

    return UserProfile(
        userName: json['userName'],
        first: json['first'],
        last: json['last'],
        groups: groupList);
  }
  Map<String, dynamic> toJson() {
    return {
      'userName': userName,
      'first': first,
      'last': last,
      'groups': groups,
    };
  }
}
