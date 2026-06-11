import 'package:flutter/material.dart';

class TestCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const TestCard({
    super.key,
    required this.title,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,

      borderRadius:
          BorderRadius.circular(16),

      child: Container(
        width: double.infinity,

        padding:
            const EdgeInsets.all(20),

        decoration: BoxDecoration(
          color: color.withOpacity(
            0.15,
          ),

          borderRadius:
              BorderRadius.circular(
            16,
          ),
        ),

        child: Row(
          children: [
            CircleAvatar(
              radius: 28,
              backgroundColor: color,

              child: Icon(
                icon,
                color: Colors.white,
              ),
            ),

            const SizedBox(width: 16),

            Expanded(
              child: Text(
                title,

                style:
                    const TextStyle(
                  fontSize: 18,
                  fontWeight:
                      FontWeight.bold,
                ),
              ),
            ),

            const Icon(
              Icons.arrow_forward_ios,
            ),
          ],
        ),
      ),
    );
  }
}