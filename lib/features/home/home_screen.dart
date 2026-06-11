import 'package:flutter/material.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import '../article/article_screen.dart';
import '../apotek/apotek_screen.dart';
import '../apotek/cart_screen.dart';
import '../eye_test/test_selection_screen.dart';
import '../history/history_screen.dart';
import '../payment/payment_screen.dart';
import '../profile/profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() =>
      _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final int eyeScore = 85;
  final int totalTests = 12;

  Future<void> exportPdf() async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (context) {
          return pw.Column(
            crossAxisAlignment:
                pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                "Laporan Kesehatan Mata",
                style: pw.TextStyle(
                  fontSize: 24,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.SizedBox(height: 20),
              pw.Text(
                "Skor Kesehatan Mata : $eyeScore/100",
              ),
              pw.Text(
                "Status : ${eyeScore >= 80 ? "Baik" : "Perlu Pemeriksaan"}",
              ),
              pw.Text(
                "Jumlah Tes : $totalTests",
              ),
              pw.SizedBox(height: 20),
              pw.Text(
                "Rekomendasi : Tetap jaga kesehatan mata dan lakukan pemeriksaan secara rutin.",
              ),
            ],
          );
        },
      ),
    );

    await Printing.layoutPdf(
      onLayout: (format) async => pdf.save(),
    );
  }

  Widget buildEyePerformanceCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
          ),
        ],
      ),
      child: Column(
        children: [
          const Row(
            children: [
              Icon(
                Icons.health_and_safety,
                color: Colors.green,
              ),
              SizedBox(width: 10),
              Text(
                "Performa Kesehatan Mata",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight:
                      FontWeight.bold,
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 120,
                height: 120,
                child:
                    CircularProgressIndicator(
                  value: eyeScore / 100,
                  strokeWidth: 10,
                ),
              ),
              Text(
                "$eyeScore%",
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight:
                      FontWeight.bold,
                ),
              ),
            ],
          ),

          const SizedBox(height: 15),

          Text(
            eyeScore >= 80
                ? "Status: Baik"
                : "Status: Perlu Pemeriksaan",
            style: TextStyle(
              color: eyeScore >= 80
                  ? Colors.green
                  : Colors.orange,
              fontWeight:
                  FontWeight.bold,
              fontSize: 16,
            ),
          ),

          const SizedBox(height: 15),

          Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Text(
                    "$totalTests",
                    style:
                        const TextStyle(
                      fontSize: 18,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),
                  const Text("Tes"),
                ],
              ),
              Column(
                children: [
                  Text(
                    "$eyeScore",
                    style:
                        const TextStyle(
                      fontSize: 18,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),
                  const Text("Skor"),
                ],
              ),
            ],
          ),

          const SizedBox(height: 20),

          SizedBox(
            width: double.infinity,
            child:
                ElevatedButton.icon(
              onPressed: exportPdf,
              icon: const Icon(
                Icons.picture_as_pdf,
              ),
              label: const Text(
                "Export PDF",
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final menus = [
      {
        "title": "Tes Mata",
        "icon": Icons.visibility,
        "screen":
            const TestSelectionScreen(),
      },
      {
        "title": "Artikel",
        "icon": Icons.article,
        "screen":
            const ArticleScreen(),
      },
      {
        "title": "Apotek",
        "icon": Icons.local_pharmacy,
        "screen":
            const ApotekScreen(),
      },
      {
        "title": "Premium",
        "icon":
            Icons.workspace_premium,
        "screen":
            const PaymentScreen(),
      },
      {
        "title": "Riwayat",
        "icon": Icons.history,
        "screen":
            const HistoryScreen(),
      },
    ];

    return Scaffold(
      backgroundColor:
          const Color(0xFFF5F8FF),
      appBar: AppBar(
        title: const Text(
          "VisionMe",
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.shopping_cart_outlined,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      const CartScreen(),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(
              Icons.person_outline,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      const ProfileScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding:
            const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding:
                  const EdgeInsets.all(
                      24),
              decoration:
                  BoxDecoration(
                gradient:
                    const LinearGradient(
                  colors: [
                    Color(0xFF2563EB),
                    Color(0xFF60A5FA),
                  ],
                ),
                borderRadius:
                    BorderRadius
                        .circular(20),
              ),
              child: const Column(
                children: [
                  Icon(
                    Icons.visibility,
                    color: Colors.white,
                    size: 60,
                  ),
                  SizedBox(height: 12),
                  Text(
                    "VisionMe",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Pemeriksaan Mata Mandiri",
                    style: TextStyle(
                      color:
                          Colors.white70,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            buildEyePerformanceCard(),

            const SizedBox(height: 20),

            GridView.builder(
              shrinkWrap: true,
              physics:
                  const NeverScrollableScrollPhysics(),
              itemCount:
                  menus.length,
              gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
                childAspectRatio: 1.1,
              ),
              itemBuilder:
                  (context, index) {
                final menu =
                    menus[index];

                return InkWell(
                  borderRadius:
                      BorderRadius
                          .circular(16),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            menu["screen"]
                                as Widget,
                      ),
                    );
                  },
                  child: Card(
                    elevation: 3,
                    shape:
                        RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius
                              .circular(
                                  16),
                    ),
                    child: Column(
                      mainAxisAlignment:
                          MainAxisAlignment
                              .center,
                      children: [
                        Icon(
                          menu["icon"]
                              as IconData,
                          size: 50,
                          color:
                              Colors.blue,
                        ),
                        const SizedBox(
                            height: 12),
                        Text(
                          menu["title"]
                              as String,
                          style:
                              const TextStyle(
                            fontSize: 16,
                            fontWeight:
                                FontWeight
                                    .bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}