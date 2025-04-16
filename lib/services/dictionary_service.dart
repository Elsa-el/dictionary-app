import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/dictionary_model.dart';

class DictionaryService {
  static Future<DictionaryResponse> fetchWordDefinition(String word) async {
    final response = await http.get(
      Uri.parse('https://api.dictionaryapi.dev/api/v2/entries/en/$word'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return DictionaryResponse.fromJson(data[0]);
    } else {
      throw Exception('Failed to load definition: ${response.statusCode}');
    }
  }
}