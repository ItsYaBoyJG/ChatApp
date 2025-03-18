import 'dart:convert';

import 'package:flutter/services.dart';

class GetMapData {
  static const String _mapJson = 'assets/json/map_data.json';

  Future readMapJson() async {
    final String response = await rootBundle.loadString(_mapJson);
    final data = await json.decode(response);
    return data['users'];
  }
}
