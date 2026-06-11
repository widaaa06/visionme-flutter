import 'package:flutter/material.dart';

class ActivityScreen extends StatelessWidget {
  const ActivityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final activities = [
      {
        "title": "Mengikuti Tes Buta Warna",
        "time": "Hari Ini • 09:15",
        "icon": Icons.visibility,
        "color": Colors.blue,
      },
      {
        "title": "Membaca Artikel Kesehatan Mata",
        "time": "Kemarin • 14:30",
        "icon": Icons.article,
        "color": Colors.orange,
      },
      {
        "title": "Membeli Vitamin Mata",
        "time": "2 Hari Lalu • 11:00",
        "icon": Icons.shopping_bag,
        "color": Colors.green,
      },
      {
        "title": "Upgrade Premium",
        "time": "5 Hari Lalu • 08:45",
        "icon": Icons.workspace_premium,
        "color": Colors.amber,
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF5F8FF),

      appBar: AppBar(
        backgroundColor: const Color(0xFF4A90E2),
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: const Text(
          "Aktivitas",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(25),
            decoration: const BoxDecoration(
              color: Color(0xFF4A90E2),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: const Column(
              children: [
                Icon(
                  Icons.history,
                  size: 60,
                  color: Colors.white,
                ),
                SizedBox(height: 12),
                Text(
                  "Riwayat Aktivitas",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  "Lihat seluruh aktivitas yang pernah dilakukan di VisionMe",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: activities.length,
              itemBuilder: (context, index) {
                final activity = activities[index];

                return Container(
                  margin: const EdgeInsets.only(bottom: 15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade200,
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ListTile(
                    contentPadding:
                        const EdgeInsets.all(15),

                    leading: Container(
                      width: 55,
                      height: 55,
                      decoration: BoxDecoration(
                        color: (activity["color"]
                                as Color)
                            .withOpacity(0.15),
                        borderRadius:
                            BorderRadius.circular(15),
                      ),
                      child: Icon(
                        activity["icon"] as IconData,
                        color:
                            activity["color"] as Color,
                      ),
                    ),

                    title: Text(
                      activity["title"] as String,
                      style: const TextStyle(
                        fontWeight:
                            FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),

                    subtitle: Padding(
                      padding:
                          const EdgeInsets.only(
                        top: 5,
                      ),
                      child: Text(
                        activity["time"] as String,
                        style: TextStyle(
                          color:
                              Colors.grey.shade600,
                        ),
                      ),
                    ),

                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: Colors.grey,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}