import 'package:equatable/equatable.dart';

class GroupId extends Equatable {
  const GroupId({required this.uId, required this.groupId});

  final String uId;
  final String groupId;

  @override
  List<Object?> get props => [uId, groupId];
}
