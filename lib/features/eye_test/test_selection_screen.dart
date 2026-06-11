import 'package:flutter/material.dart';

import '../../services/auth_service.dart';
import '../../widgets/premium_dialog.dart';

import 'color_blind_test_screen.dart';
import 'landolt_test_screen.dart';
import 'snellen_test_screen.dart';
import 'level_selection_screen.dart';

class TestSelectionScreen extends StatelessWidget {
  const TestSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tes Mata'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _buildCard(
              context,
              title: 'Tes Buta Warna',
              icon: Icons.palette,
              color: Colors.orange,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => LevelSelectionScreen(
                      title: 'Tes Buta Warna',
                      onLevelSelected: (level) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ColorBlindTestScreen(level: level),
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: 16),

            _buildCard(
              context,
              title: 'Tes Snellen ',
              icon: Icons.visibility,
              color: Colors.blue,
              onTap: () async {
                final isUser = await AuthService().isLoggedIn();

                if (!isUser) {
                  PremiumDialog.show(context);
                  return;
                }

                if (!context.mounted) return;

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => LevelSelectionScreen(
                      title: 'Tes Snellen',
                      onLevelSelected: (level) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => SnellenTestScreen(level: level),
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: 16),

            _buildCard(
              context,
              title: 'Tes Landolt',
              icon: Icons.remove_red_eye,
              color: Colors.green,
              onTap: () async {
                final isUser = await AuthService().isLoggedIn();

                if (!isUser) {
                  PremiumDialog.show(context);
                  return;
                }

                if (!context.mounted) return;

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => LevelSelectionScreen(
                      title: 'Tes Landolt',
                      onLevelSelected: (level) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => LandoltTestScreen(level: level),
                          ),
                        );
                      },
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

  Widget _buildCard(
    BuildContext context, {
    required String title,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: color.withOpacity(0.15),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color.withOpacity(0.5)),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 28,
              backgroundColor: color,
              child: Icon(icon, color: Colors.white, size: 28),
            ),

            const SizedBox(width: 16),

            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const Icon(Icons.arrow_forward_ios, size: 18),
          ],
        ),
      ),
    );
  }
}
