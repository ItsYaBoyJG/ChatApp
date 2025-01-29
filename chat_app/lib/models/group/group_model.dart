import 'package:chat_app/models/group/member_model.dart';

class GroupModel {
  GroupModel(
      {required this.createdBy, required this.groupId, required this.members});

  final String createdBy;
  final String groupId;
  final List members;

  factory GroupModel.fromJson(Map<String, dynamic> json) {
    var membersFromJson = json['members'] as List;
    List membersList =
        membersFromJson.map((i) => MemberModel.fromJson(i)).toList();
    return GroupModel(
        createdBy: json['createdBy'],
        groupId: json['groupId'],
        members: membersList);
  }

  Map<String, dynamic> toJson() {
    return {
      'createdBy': createdBy,
      'groupId': groupId,
      'members': members,
    };
  }
}
