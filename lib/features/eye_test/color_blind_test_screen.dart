import 'package:flutter/material.dart';
import '../../services/pemeriksaan_service.dart';
import 'test_result_screen.dart';

class ColorBlindTestScreen extends StatefulWidget {
  final String level;

  const ColorBlindTestScreen({super.key, required this.level});

  @override
  State<ColorBlindTestScreen> createState() => _ColorBlindTestScreenState();
}

class _ColorBlindTestScreenState extends State<ColorBlindTestScreen> {
  int currentQuestion = 0;
  int score = 0;
  bool isLoading = false;

  late List<Map<String, dynamic>> questions;
  final TextEditingController answerController = TextEditingController();

  // KUNCI JAWABAN SUDAH DISINKRONKAN DENGAN STANDAR BUKU ISHIHARA ASLI
  final Map<String, List<Map<String, dynamic>>> questionsByLevel = {
    'Easy': [
      {
        'image': 'assets/ishihara/ishihara_1.jpg',
        'answer': '12',
      }, // Plate 1: Semua orang harus bisa lihat 12
      {
        'image': 'assets/ishihara/ishihara_2.jpg',
        'answer': '8',
      }, // Plate 2: Normal lihat 8
      {
        'image': 'assets/ishihara/ishihara_3.jpg',
        'answer': '5',
      }, // Plate 3: Normal lihat 5
      {
        'image': 'assets/ishihara/ishihara_4.jpg',
        'answer': '29',
      }, // Plate 4: Normal lihat 29
      {
        'image': 'assets/ishihara/ishihara_5.jpg',
        'answer': '74',
      }, // Plate 5: Normal lihat 74
    ],
    'Medium': [
      {
        'image': 'assets/ishihara/ishihara_6.jpg',
        'answer': '7',
      }, // Plate 6: Normal lihat 7
      {
        'image': 'assets/ishihara/ishihara_7.jpg',
        'answer': '45',
      }, // Plate 7: Normal lihat 45
      {
        'image': 'assets/ishihara/ishihara_8.jpg',
        'answer': '2',
      }, // Plate 8: Normal lihat 2
      {
        'image': 'assets/ishihara/ishihara_9.jpg',
        'answer': 'none',
      }, // Plate 9: Normal tidak lihat angka (ketik 'none' atau kosong)
      {
        'image': 'assets/ishihara/ishihara_10.jpg',
        'answer': '16',
      }, // Plate 10: Normal lihat 16
    ],
    'Hard': [
      {
        'image': 'assets/ishihara/ishihara_11.jpg',
        'answer': '35',
      }, // Plate 11: Normal lihat 35
      {
        'image': 'assets/ishihara/ishihara_12.jpg',
        'answer': '96',
      }, // Plate 12: Normal lihat 96
      {
        'image': 'assets/ishihara/ishihara_13.jpg',
        'answer': '26',
      }, // Plate 13: Normal lihat 26
      {
        'image': 'assets/ishihara/ishihara_14.jpg',
        'answer': '42',
      }, // Plate 14: Normal lihat 42
      {
        'image': 'assets/ishihara/ishihara_15.jpg',
        'answer': '15',
      }, // Plate 15: Normal lihat 15
    ],
    'Campuran': [
      {'image': 'assets/ishihara/ishihara_1.jpg', 'answer': '12'},
      {'image': 'assets/ishihara/ishihara_4.jpg', 'answer': '29'},
      {'image': 'assets/ishihara/ishihara_7.jpg', 'answer': '45'},
      {'image': 'assets/ishihara/ishihara_12.jpg', 'answer': '96'},
      {'image': 'assets/ishihara/ishihara_14.jpg', 'answer': '42'},
    ],
  };

  @override
  void initState() {
    super.initState();
    questions = List.from(questionsByLevel[widget.level]!);
    // Catatan: Jika ingin urutan gambar sesuai dari nomor 1-5 terus,
    // Anda bisa menghapus fungsi questions.shuffle() di bawah ini.
    questions.shuffle();
  }

  Future<void> checkAnswer() async {
    // Menghilangkan spasi dan mengubah ke huruf kecil jika user mengetik huruf
    final userAnswer = answerController.text.trim().toLowerCase();

    if (userAnswer.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Silakan masukkan jawaban Anda')),
      );
      return;
    }

    final correctAnswer = questions[currentQuestion]['answer']
        .toString()
        .toLowerCase();

    // Validasi penambahan skor jika jawaban user sama persis dengan kunci jawaban gambar
    if (userAnswer == correctAnswer) {
      score++;
    }

    answerController.clear();

    if (currentQuestion < questions.length - 1) {
      setState(() {
        currentQuestion++;
      });
    } else {
      setState(() {
        isLoading = true;
      });

      String result;
      if (score == questions.length) {
        result = 'Normal';
      } else if (score >= 3) {
        result = 'Perlu Pemeriksaan Lanjutan';
      } else {
        result = 'Indikasi Buta Warna';
      }

      try {
        await PemeriksaanService().simpanHasil(
          kategoriUji: "Buta Warna",
          hasilPengukuran: "$score/${questions.length}",
          statusMedis: result,
        );
      } catch (e) {
        debugPrint("Gagal menyimpan hasil: $e");
      }

      if (!mounted) return;

      setState(() {
        isLoading = false;
      });

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => TestResultScreen(
            testName: 'Tes Buta Warna',
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
        title: Text('Tes Buta Warna (${widget.level})'),
        centerTitle: true,
      ),
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Soal ${currentQuestion + 1}/${questions.length}',
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 15),

              LinearProgressIndicator(
                value: (currentQuestion + 1) / questions.length,
                minHeight: 6,
              ),
              const SizedBox(height: 30),

              Center(
                child: Image.asset(
                  question['image'],
                  width: 260,
                  height: 260,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 25),

              const Text(
                'Masukkan angka yang terlihat',
                style: TextStyle(fontSize: 18),
              ),
              const Text(
                '(Ketik "none" jika tidak melihat angka sama sekali)',
                style: TextStyle(fontSize: 13, color: Colors.grey),
              ),
              const SizedBox(height: 15),

              TextField(
                controller: answerController,
                // Menggunakan text biasa karena ada plate Ishihara yang jawabannya kosong/none
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.done,
                onSubmitted: (_) => isLoading ? null : checkAnswer(),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                  labelText: 'Jawaban',
                  hintText: 'Contoh: 12 atau none',
                ),
              ),
              const SizedBox(height: 25),

              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: isLoading ? null : () => checkAnswer(),
                  child: isLoading
                      ? const SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.5,
                            color: Colors.white,
                          ),
                        )
                      : const Text('Submit', style: TextStyle(fontSize: 18)),
                ),
              ),
              const SizedBox(height: 40),

              Text(
                'Skor Sementara: $score',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    answerController.dispose();
    super.dispose();
  }
}
