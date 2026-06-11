import 'package:flutter/material.dart';

import '../../services/pemeriksaan_service.dart';
import 'test_result_screen.dart';

class SnellenTestScreen extends StatefulWidget {
  final String level;

  const SnellenTestScreen({super.key, required this.level});

  @override
  State<SnellenTestScreen> createState() => _SnellenTestScreenState();
}

class _SnellenTestScreenState extends State<SnellenTestScreen> {
  int currentQuestion = 0;
  int score = 0;

  late List<Map<String, dynamic>> questions;

  final Map<String, List<Map<String, dynamic>>> questionsByLevel = {
    'Easy': [
      {
        'letter': 'E',
        'size': 120.0,
        'answer': 'E',
        'options': ['E', 'F', 'P', 'T'],
      },
      {
        'letter': 'F',
        'size': 110.0,
        'answer': 'F',
        'options': ['E', 'F', 'P', 'L'],
      },
      {
        'letter': 'P',
        'size': 100.0,
        'answer': 'P',
        'options': ['P', 'T', 'E', 'F'],
      },
      {
        'letter': 'T',
        'size': 95.0,
        'answer': 'T',
        'options': ['L', 'T', 'F', 'E'],
      },
      {
        'letter': 'O',
        'size': 90.0,
        'answer': 'O',
        'options': ['O', 'Q', 'D', 'C'],
      },
    ],
    'Medium': [
      {
        'letter': 'L',
        'size': 80.0,
        'answer': 'L',
        'options': ['L', 'I', 'T', 'F'],
      },
      {
        'letter': 'D',
        'size': 75.0,
        'answer': 'D',
        'options': ['D', 'O', 'Q', 'C'],
      },
      {
        'letter': 'F',
        'size': 70.0,
        'answer': 'F',
        'options': ['F', 'P', 'E', 'T'],
      },
      {
        'letter': 'P',
        'size': 65.0,
        'answer': 'P',
        'options': ['P', 'R', 'B', 'D'],
      },
      {
        'letter': 'E',
        'size': 60.0,
        'answer': 'E',
        'options': ['E', 'F', 'B', 'L'],
      },
    ],
    'Hard': [
      {
        'letter': 'Z',
        'size': 45.0,
        'answer': 'Z',
        'options': ['Z', 'N', 'M', 'W'],
      },
      {
        'letter': 'N',
        'size': 40.0,
        'answer': 'N',
        'options': ['N', 'H', 'M', 'K'],
      },
      {
        'letter': 'K',
        'size': 38.0,
        'answer': 'K',
        'options': ['K', 'X', 'Y', 'N'],
      },
      {
        'letter': 'V',
        'size': 35.0,
        'answer': 'V',
        'options': ['V', 'Y', 'W', 'X'],
      },
      {
        'letter': 'H',
        'size': 32.0,
        'answer': 'H',
        'options': ['H', 'N', 'M', 'K'],
      },
    ],
    'Campuran': [
      {
        'letter': 'E',
        'size': 120.0,
        'answer': 'E',
        'options': ['E', 'F', 'P', 'T'],
      },
      {
        'letter': 'F',
        'size': 100.0,
        'answer': 'F',
        'options': ['F', 'E', 'L', 'T'],
      },
      {
        'letter': 'P',
        'size': 70.0,
        'answer': 'P',
        'options': ['P', 'F', 'E', 'T'],
      },
      {
        'letter': 'L',
        'size': 60.0,
        'answer': 'L',
        'options': ['L', 'I', 'T', 'F'],
      },
      {
        'letter': 'Z',
        'size': 40.0,
        'answer': 'Z',
        'options': ['Z', 'N', 'M', 'W'],
      },
    ],
  };

  @override
  void initState() {
    super.initState();

    questions = List.from(questionsByLevel[widget.level]!);
  }

  Future<void> checkAnswer(String selectedAnswer) async {
    if (selectedAnswer == questions[currentQuestion]['answer']) {
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
          kategoriUji: "Snellen Chart",
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
            testName: "Tes Snellen",
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
        title: Text('Tes Snellen (${widget.level})'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              'Soal ${currentQuestion + 1}/${questions.length}',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),
            LinearProgressIndicator(
              value: (currentQuestion + 1) / questions.length,
            ),
            const SizedBox(height: 40),
            Text(
              question['letter'],
              style: TextStyle(
                fontSize: question['size'],
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              'Huruf apakah yang terlihat?',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                children: List.generate(question['options'].length, (index) {
                  final option = question['options'][index];

                  return ElevatedButton(
                    onPressed: () {
                      checkAnswer(option);
                    },
                    child: Text(
                      option,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                }),
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
