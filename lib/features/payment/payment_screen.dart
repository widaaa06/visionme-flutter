import 'package:flutter/material.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pembayaran"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Icon(
              Icons.payment,
              size: 100,
              color: Colors.green,
            ),

            const SizedBox(height: 20),

            const Text(
              "Metode Pembayaran",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            Card(
              child: ListTile(
                leading: const Icon(Icons.account_balance),
                title: const Text("Transfer Bank"),
                subtitle: const Text("BCA / BRI / Mandiri"),
                onTap: () {
                  _showSuccess(context);
                },
              ),
            ),

            Card(
              child: ListTile(
                leading: const Icon(Icons.qr_code),
                title: const Text("QRIS"),
                subtitle: const Text("Scan QR untuk membayar"),
                onTap: () {
                  _showSuccess(context);
                },
              ),
            ),

            Card(
              child: ListTile(
                leading: const Icon(Icons.wallet),
                title: const Text("E-Wallet"),
                subtitle: const Text("Dana / OVO / GoPay"),
                onTap: () {
                  _showSuccess(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  static void _showSuccess(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Pembayaran Berhasil"),
        content: const Text(
          "Terima kasih telah melakukan pembayaran.",
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }
}