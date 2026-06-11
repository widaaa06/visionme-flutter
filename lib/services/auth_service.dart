import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const String baseUrl = "https://visionme.cicd.my.id/api";

  // LOGIN
  Future<bool> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/login"),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/x-www-form-urlencoded",
        },
        body: {"email": email, "password": password},
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        final prefs = await SharedPreferences.getInstance();

        await prefs.setString("token", data["token"]);
        await prefs.setInt("user_id", data["user"]["id"]);
        await prefs.setString("user_name", data["user"]["name"]);
        await prefs.setString("user_email", data["user"]["email"]);

        return true;
      }

      return false;
    } catch (e) {
      print("LOGIN ERROR : $e");
      return false;
    }
  }

  // REGISTER
  // Diubah menjadi Future<String?> agar sinkron dengan RegisterScreen
  Future<String?> register({
    required String name,
    required String email,
    required String password,
    required String passwordConfirmation,
  }) async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/register"),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/x-www-form-urlencoded",
        },
        body: {
          "name": name,
          "email": email,
          "password": password,
          "password_confirmation": passwordConfirmation,
        },
      );

      print(response.body);
      final data = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return null; // Return null jika sukses (tidak ada error)
      }

      // Mengembalikan pesan error dari API, jika tidak ada pakai pesan default
      return data["message"] ?? "Terjadi kesalahan saat registrasi.";
    } catch (e) {
      print("REGISTER ERROR : $e");
      return "Gagal terhubung ke server.";
    }
  }

  // LOGOUT
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token");

    if (token != null) {
      await http.post(
        Uri.parse("$baseUrl/logout"),
        headers: {
          "Authorization": "Bearer $token",
          "Accept": "application/json",
        },
      );
    }

    await prefs.clear();
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("token");
  }

  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey("token");
  }

  Future<String?> getUserName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("user_name");
  }

  Future<String?> getUserEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("user_email");
  }
}
