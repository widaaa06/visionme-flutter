import 'dart:convert';
import 'package:http/http.dart' as http;

import 'auth_service.dart';

class HistoryService {
  static const String baseUrl = "https://visionme.cicd.my.id/api";

  static Future<bool> saveHistory({
    required String testName,
    required String level,
    required int score,
  }) async {
    try {
      final token = await AuthService().getToken();

      final response = await http.post(
        Uri.parse("$baseUrl/riwayat-pemeriksaan"),
        headers: {
          "Authorization": "Bearer $token",
          "Accept": "application/json",
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "test_name": testName,
          "level": level,
          "score": score,
        }),
      );

      return response.statusCode == 200 || response.statusCode == 201;
    } catch (e) {
      print("SAVE HISTORY ERROR: $e");
      return false;
    }
  }

  Future<List<dynamic>> getRiwayat() async {
    try {
      final token = await AuthService().getToken();

      final response = await http.get(
        Uri.parse("$baseUrl/riwayat-pemeriksaan"),
        headers: {
          "Authorization": "Bearer $token",
          "Accept": "application/json",
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        return data["data"] ?? [];
      }

      return [];
    } catch (e) {
      print(e);
      return [];
    }
  }
}
