import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  static const String baseUrl = "http://192.168.8.166:8000/api";

  static Future<Map<String, dynamic>> loginWithPin(String userId, String pin) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"user_id": userId, "user_pin": pin}),
    );
    return jsonDecode(response.body);
  }

  static Future<Map<String, dynamic>> loginWithUsername(String username, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"user_name": username, "password": password}),
    );
    return jsonDecode(response.body);
  }
}
