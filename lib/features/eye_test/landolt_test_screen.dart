import 'package:flutter/material.dart';

import '../../services/pemeriksaan_service.dart';
import 'test_result_screen.dart';

class LandoltTestScreen extends StatefulWidget {
  final String level;

  const LandoltTestScreen({super.key, required this.level});

  @override
  State<LandoltTestScreen> createState() => _LandoltTestScreenState();
}

class _LandoltTestScreenState extends State<LandoltTestScreen> {
  int currentQuestion = 0;
  int score = 0;

  late List<Map<String, dynamic>> questions;

  final Map<String, List<Map<String, dynamic>>> questionsByLevel = {
    'Easy': [
      {'direction': 'Kanan', 'size': 120.0},
      {'direction': 'Kiri', 'size': 120.0},
      {'direction': 'Atas', 'size': 120.0},
      {'direction': 'Bawah', 'size': 120.0},
      {'direction': 'Kanan', 'size': 120.0},
    ],
    'Medium': [
      {'direction': 'Kiri', 'size': 90.0},
      {'direction': 'Atas', 'size': 90.0},
      {'direction': 'Bawah', 'size': 90.0},
      {'direction': 'Kanan', 'size': 90.0},
      {'direction': 'Kiri', 'size': 90.0},
    ],
    'Hard': [
      {'direction': 'Atas', 'size': 60.0},
      {'direction': 'Bawah', 'size': 60.0},
      {'direction': 'Kanan', 'size': 60.0},
      {'direction': 'Kiri', 'size': 60.0},
      {'direction': 'Atas', 'size': 60.0},
    ],
    'Campuran': [
      {'direction': 'Kanan', 'size': 120.0},
      {'direction': 'Atas', 'size': 90.0},
      {'direction': 'Bawah', 'size': 60.0},
      {'direction': 'Kiri', 'size': 90.0},
      {'direction': 'Kanan', 'size': 60.0},
    ],
  };

  @override
  void initState() {
    super.initState();

    questions = List.from(questionsByLevel[widget.level]!);
  }

  IconData getLandoltIcon(String direction) {
    switch (direction) {
      case 'Kanan':
        return Icons.keyboard_arrow_right;

      case 'Kiri':
        return Icons.keyboard_arrow_left;

      case 'Atas':
        return Icons.keyboard_arrow_up;

      case 'Bawah':
        return Icons.keyboard_arrow_down;

      default:
        return Icons.circle;
    }
  }

  Future<void> checkAnswer(String answer) async {
    if (answer == questions[currentQuestion]['direction']) {
      score++;
    }

    if (currentQuestion < questions.length - 1) {
      setState(() {
        currentQuestion++;
      });
    } else {
      String result;

      if (score >= 4) {
        result = "Penglihatan Sangat Baik";
      } else if (score >= 2) {
        result = "Penglihatan Cukup Baik";
      } else {
        result = "Perlu Pemeriksaan Lanjutan";
      }

      try {
        await PemeriksaanService().simpanHasil(
          kategoriUji: "Astigmatisme",
          hasilPengukuran: "$score/5",
          statusMedis: result,
        );
      } catch (e) {
        debugPrint("Gagal menyimpan hasil: $e");
      }

      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => TestResultScreen(
            testName: "Tes Landolt",
            level: widget.level,
            score: score,
            result: result,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final question = questions[currentQuestion];

    return Scaffold(
      appBar: AppBar(
        title: Text('Tes Landolt (${widget.level})'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              'Soal ${currentQuestion + 1}/${questions.length}',
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 15),

            LinearProgressIndicator(
              value: (currentQuestion + 1) / questions.length,
            ),

            const SizedBox(height: 40),

            Icon(getLandoltIcon(question['direction']), size: question['size']),

            const SizedBox(height: 30),

            const Text('Arah bukaan Landolt?', style: TextStyle(fontSize: 18)),

            const SizedBox(height: 20),

            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      checkAnswer('Kanan');
                    },
                    child: const Text('Kanan'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      checkAnswer('Kiri');
                    },
                    child: const Text('Kiri'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      checkAnswer('Atas');
                    },
                    child: const Text('Atas'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      checkAnswer('Bawah');
                    },
                    child: const Text('Bawah'),
                  ),
                ],
              ),
            ),

            Text(
              'Skor: $score',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
