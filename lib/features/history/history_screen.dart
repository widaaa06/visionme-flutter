import 'package:flutter/material.dart';
import '../../../services/history_service.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  final HistoryService _historyService = HistoryService();

  List<dynamic> history = [];

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadHistory();
  }

  Future<void> loadHistory() async {
    final data = await _historyService.getRiwayat();

    setState(() {
      history = data;
      isLoading = false;
    });
  }

  IconData getIcon(String kategori) {
    switch (kategori) {
      case "Buta Warna":
        return Icons.palette;

      case "Snellen Chart":
        return Icons.visibility;

      case "Astigmatisme":
        return Icons.remove_red_eye;

      default:
        return Icons.medical_services;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F8FF),

      appBar: AppBar(
        backgroundColor: const Color(0xFF4A90E2),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Riwayat Tes",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),

      body: Column(
        children: [
          Container(
            width: double.infinity,
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: const LinearGradient(
                colors: [Color(0xFF4A90E2), Color(0xFF6BB7FF)],
              ),
            ),
            child: Column(
              children: [
                const Icon(Icons.history, color: Colors.white, size: 50),
                const SizedBox(height: 10),
                Text(
                  "${history.length} Riwayat Pemeriksaan",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : history.isEmpty
                ? const Center(child: Text("Belum ada riwayat pemeriksaan"))
                : RefreshIndicator(
                    onRefresh: loadHistory,
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: history.length,
                      itemBuilder: (context, index) {
                        final item = history[index];

                        return Container(
                          margin: const EdgeInsets.only(bottom: 15),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.shade200,
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(15),

                            leading: Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                color: Colors.blue.shade50,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Icon(
                                getIcon(item["kategori_uji"]),
                                color: const Color(0xFF4A90E2),
                                size: 30,
                              ),
                            ),

                            title: Text(
                              item["kategori_uji"],
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),

                            subtitle: Padding(
                              padding: const EdgeInsets.only(top: 6),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Hasil: ${item["hasil_pengukuran"]}",
                                    style: const TextStyle(
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),

                                  const SizedBox(height: 4),

                                  Text("Status: ${item["status_medis"]}"),

                                  const SizedBox(height: 4),

                                  Text(
                                    item["created_at"] ?? "",
                                    style: TextStyle(
                                      color: Colors.grey.shade600,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            trailing: const Icon(
                              Icons.arrow_forward_ios,
                              size: 18,
                              color: Colors.grey,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
