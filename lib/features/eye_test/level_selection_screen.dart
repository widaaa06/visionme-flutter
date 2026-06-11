import 'package:flutter/material.dart';

class LevelSelectionScreen extends StatelessWidget {
  final String title;
  final Function(String level) onLevelSelected;

  const LevelSelectionScreen({
    super.key,
    required this.title,
    required this.onLevelSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _buildButton(
              context,
              'Easy',
              Colors.green,
              Icons.sentiment_satisfied,
            ),

            const SizedBox(height: 16),

            _buildButton(
              context,
              'Medium',
              Colors.orange,
              Icons.sentiment_neutral,
            ),

            const SizedBox(height: 16),

            _buildButton(
              context,
              'Hard',
              Colors.red,
              Icons.sentiment_dissatisfied,
            ),

            const SizedBox(height: 16),

            _buildButton(
              context,
              'Campuran',
              Colors.blue,
              Icons.shuffle,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(
    BuildContext context,
    String level,
    Color color,
    IconData icon,
  ) {
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: ElevatedButton.icon(
        onPressed: () {
          onLevelSelected(level);
        },
        icon: Icon(icon),
        label: Text(
          level,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
    );
  }
}