import 'dart:convert';

import 'package:chat_app/models/user/user_model.dart';
import 'package:flutter/services.dart';

class GetChatData {
  final _filepath = 'assets/json/snapchat_mock_data.json';

  Future<List<UserProfile>> loadUsers() async {
    final String response = await rootBundle.loadString(_filepath);
    final data = json.decode(response);
    var usersFromJson = data['users'] as List;
    return usersFromJson
        .map((userJson) => UserProfile.fromJson(userJson))
        .toList();
  }
}
