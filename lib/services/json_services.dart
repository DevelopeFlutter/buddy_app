import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class JsonService {
  static Future<Map<String, dynamic>> loadJsonData() async {
    String jsonString = await rootBundle.loadString('assets/mock_data.json');
    return json.decode(jsonString);
  }
}
