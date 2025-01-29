import 'dart:convert';

import 'package:chat_app/models/images/profile_picture.dart';
import 'package:flutter/services.dart';

class GetProfilePic {
  final _filepath = 'assets/json/profile_picture.json';

  Future<List<ProfilePicture>> loadProfilePicture() async {
    final String response = await rootBundle.loadString(_filepath);
    final data = json.decode(response);
    var pictureFromJson = data['snapshots'] as List;
    return pictureFromJson
        .map((json) => ProfilePicture.fromJson(json))
        .toList();
  }
}
