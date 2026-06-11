import 'dart:convert';
import 'package:http/http.dart' as http;
import 'auth_service.dart';

class PemeriksaanService {
  static const String baseUrl = "https://visionme.cicd.my.id/api";

  Future<bool> simpanHasil({
    required String kategoriUji,
    required String hasilPengukuran,
    required String statusMedis,
  }) async {
    try {
      final token = await AuthService().getToken();

      final response = await http.post(
        Uri.parse("$baseUrl/pemeriksaan/store"),
        headers: {
          "Authorization": "Bearer $token",
          "Accept": "application/json",
        },
        body: {
          "kategori_uji": kategoriUji,
          "hasil_pengukuran": hasilPengukuran,
          "status_medis": statusMedis,
        },
      );

      return response.statusCode == 201 || response.statusCode == 200;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
