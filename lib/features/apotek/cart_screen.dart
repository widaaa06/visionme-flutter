import 'package:flutter/material.dart';

import 'cart_service.dart';
import '../payment/payment_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() =>
      _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  int get totalPrice {
    int total = 0;

    for (var item in CartService.items) {
      String price =
          item["price"].replaceAll("Rp ", "").replaceAll(".", "");

      total += int.tryParse(price) ?? 0;
    }

    return total;
  }

  String formatTotal(int value) {
    return "Rp ${value.toString().replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]}.',
        )}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F8FF),

      appBar: AppBar(
        backgroundColor: const Color(0xFF4A90E2),
        title: const Text(
          "Keranjang Saya",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        iconTheme:
            const IconThemeData(color: Colors.white),
      ),

      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: CartService.items.length,
              itemBuilder: (context, index) {
                final item =
                    CartService.items[index];

                return ListTile(
                  title: Text(item["name"]),
                  subtitle: Text(item["price"]),
                  trailing: IconButton(
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                    onPressed: () {
                      setState(() {
                        CartService.removeItem(
                            index);
                      });
                    },
                  ),
                );
              },
            ),
          ),

          Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Text(
                  "Total: ${formatTotal(totalPrice)}",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 10),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(
                      backgroundColor:
                          const Color(0xFF4A90E2),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              const PaymentScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      "Checkout",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}