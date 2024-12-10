import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:snapchat_clone/models/user/user_model.dart';

class GetChatData {
  final _filepath = 'assets/json/snapchat_mock_data.json';

  Future<List<User>> loadUsers() async {
    final String response = await rootBundle.loadString(_filepath);
    final data = json.decode(response);
    var usersFromJson = data['users'] as List;
    return usersFromJson.map((userJson) => User.fromJson(userJson)).toList();
  }
}
