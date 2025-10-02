import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:muud_health/core/string.dart';
import 'package:muud_health/model/jorunal_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class JournalApi {
  // static const String baseUrl = 'https://f602-85-237-194-107.ngrok-free.app';

  static Future<List<JournalEntry>> fetchUserEntries() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');
    final response = await http.get(
      Uri.parse('$baseUrl/journal/user'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((e) => JournalEntry.fromJson(e)).toList();
    } else {
      throw Exception('Failed to fetch journal entries');
    }
  }
  static Future<void> submitEntry({
  required String entryText,
  required int moodRating,
  required DateTime timestamp,
}) async {
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('auth_token');

  final response = await http.post(
    Uri.parse('$baseUrl/journal/entry'),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    },
    body: jsonEncode({
      'entry_text': entryText,
      'mood_rating': moodRating,
      'timestamp': timestamp.toUtc().toIso8601String(),
    }),
  );

  if (response.statusCode != 201) {
    throw Exception('Failed to submit journal entry');
  }
}

}

