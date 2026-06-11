import 'package:flutter/material.dart';

import '../../services/auth_service.dart';
import '../../services/pdf_service.dart';

class TestResultScreen extends StatefulWidget {
  final String result;
  final String testName;
  final String level;
  final int score;

  const TestResultScreen({
    super.key,
    required this.result,
    required this.testName,
    required this.level,
    required this.score,
  });

  @override
  State<TestResultScreen> createState() => _TestResultScreenState();
}

class _TestResultScreenState extends State<TestResultScreen> {
  bool isUser = false;

  @override
  void initState() {
    super.initState();
    loadRole();
  }

  Future<void> loadRole() async {
    isUser = await AuthService().isLoggedIn();

    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Hasil Tes")),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: isUser ? _buildUserResult() : _buildGuestResult(),
          ),
        ),
      ),
    );
  }

  Widget _buildGuestResult() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.check_circle, color: Colors.green, size: 100),
        const SizedBox(height: 20),
        const Text(
          "HASIL TES",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        Text(
          widget.result,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 18),
        ),
        const SizedBox(height: 20),
        const Text(
          "Untuk melihat analisis lengkap,\nriwayat tes, dan mengunduh PDF,\nsilakan login sebagai pengguna.",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.grey),
        ),
        const SizedBox(height: 25),
        ElevatedButton.icon(
          onPressed: () {
            Navigator.pushNamed(context, '/login');
          },
          icon: const Icon(Icons.login),
          label: const Text("Login Sekarang"),
        ),
      ],
    );
  }

  Widget _buildUserResult() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.check_circle, color: Colors.green, size: 100),
        const SizedBox(height: 20),
        const Text(
          "HASIL TES",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        Text(
          widget.result,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 18),
        ),
        const SizedBox(height: 20),
        const Text(
          "Interpretasi",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        const SizedBox(height: 8),
        Text(_getInterpretation(), textAlign: TextAlign.center),
        const SizedBox(height: 20),
        const Text(
          "Rekomendasi",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        const SizedBox(height: 8),
        Text(_getRecommendation(), textAlign: TextAlign.center),
        const SizedBox(height: 30),
        ElevatedButton.icon(
          onPressed: () async {
            await PdfService.generateResultPdf(
              testName: widget.testName,
              level: widget.level,
              score: widget.score,
              result: widget.result,
            );

            if (!mounted) return;

            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("PDF berhasil dibuat")),
            );
          },
          icon: const Icon(Icons.picture_as_pdf),
          label: const Text("Download PDF"),
        ),
      ],
    );
  }

  String _getInterpretation() {
    if (widget.result.contains("Sangat Baik")) {
      return "Kemampuan penglihatan berada pada kategori sangat baik.";
    }

    if (widget.result.contains("Cukup Baik")) {
      return "Kemampuan penglihatan masih dalam batas normal namun perlu dijaga.";
    }

    if (widget.result.contains("Normal")) {
      return "Tidak ditemukan indikasi buta warna berdasarkan hasil tes.";
    }

    return "Disarankan melakukan pemeriksaan lebih lanjut dengan tenaga medis profesional.";
  }

  String _getRecommendation() {
    if (widget.result.contains("Sangat Baik")) {
      return "Pertahankan pola hidup sehat dan lakukan pemeriksaan rutin setiap 6 bulan.";
    }

    if (widget.result.contains("Cukup Baik")) {
      return "Kurangi kelelahan mata dan lakukan pemeriksaan berkala.";
    }

    if (widget.result.contains("Normal")) {
      return "Lakukan tes ulang secara berkala untuk memantau kesehatan mata.";
    }

    return "Segera konsultasikan dengan dokter mata untuk pemeriksaan lebih lanjut.";
  }
}
