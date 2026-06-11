import 'package:flutter/material.dart';

class PremiumDialog {
  static void show(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            "Fitur Premium",
          ),
          content: const Text(
            "Silakan login untuk mengakses fitur ini.",
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Tutup"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);

                Navigator.pushNamed(
                  context,
                  '/login',
                );
              },
              child: const Text(
                "Login",
              ),
            ),
          ],
        );
      },
    );
  }
}