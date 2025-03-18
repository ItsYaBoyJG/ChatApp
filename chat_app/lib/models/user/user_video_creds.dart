import 'package:stream_video_flutter/stream_video_flutter.dart';

class UserVideoCredentials {
  const UserVideoCredentials({required this.userInfo, required this.userToken});
  final UserInfo userInfo;
  final UserToken userToken;

  factory UserVideoCredentials.fromJson(Map<String, dynamic> json) {
    return UserVideoCredentials(
        userInfo: _fromJson(json['user']),
        userToken: UserToken.jwt(json['token']));
  }

  Map<String, dynamic> toJson() {
    return {
      'token': userToken.rawValue,
      'user': userInfo.toJson(),
    };
  }
}

UserInfo _fromJson(Map<String, dynamic> json) {
  return UserInfo(id: json['id']);
}
