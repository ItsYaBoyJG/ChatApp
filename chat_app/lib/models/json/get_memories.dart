import 'dart:convert';

import 'package:chat_app/models/images/memories_model.dart';
import 'package:flutter/services.dart';

class GetMemories {
  final _filepath = 'assets/json/memories.json';

  Future<List<Memories>> loadMemories() async {
    final String response = await rootBundle.loadString(_filepath);
    final data = json.decode(response);
    var memsFromJson = data['snapshots'] as List;
    print(memsFromJson);
    print(memsFromJson.map((memsJson) => Memories.fromJson(memsJson)).toList());
    return memsFromJson.map((memsJson) => Memories.fromJson(memsJson)).toList();
  }
}
