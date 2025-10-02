import 'dart:convert';
import 'package:muud_health/core/string.dart';
import 'package:muud_health/model/contact_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ContactApi {
  static Future<Contact> addContact({
  required String name,
  required String email,
}) async {
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('auth_token');

  final response = await http.post(
    Uri.parse('$baseUrl/contacts/add'),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    },
    body: jsonEncode({
      'contact_name': name,
      'contact_email': email,
    }),
  );

  if (response.statusCode == 201) {
    final json = jsonDecode(response.body);
    if (json['success'] == true) {
      return Contact(
        id: json['contact_id'],
        name: name,
        email: email,
      );
    } else {
      throw Exception('Server rejected contact creation');
    }
  } else {
    throw Exception('Failed to create contact');
  }
}
static Future<List<Contact>> fetchUserContacts() async {
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('auth_token');
  final userId = prefs.getString('userId'); // make sure it was saved as string

  if (token == null || userId == null) {
    throw Exception('Missing token or user ID');
  }

  final response = await http.get(
    Uri.parse('$baseUrl/contacts/user/$userId'),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    },
  );

  if (response.statusCode == 200) {
    final List data = jsonDecode(response.body);
    return data.map((json) => Contact.fromJson(json)).toList();
  } else {
    throw Exception('Failed to fetch contacts');
  }
}


}