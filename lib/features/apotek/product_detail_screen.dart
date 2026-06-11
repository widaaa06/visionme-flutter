import 'package:flutter/material.dart';

import 'cart_screen.dart';
import 'cart_service.dart';
import '../payment/payment_screen.dart';

class ProductDetailScreen extends StatelessWidget {
  final String productName;
  final String price;

  const ProductDetailScreen({
    super.key,
    required this.productName,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F8FF),

      appBar: AppBar(
        backgroundColor: const Color(0xFF4A90E2),
        title: Text(
          productName,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        iconTheme:
            const IconThemeData(color: Colors.white),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 20),

            const Icon(
              Icons.medication,
              size: 120,
              color: Color(0xFF4A90E2),
            ),

            const SizedBox(height: 20),

            Text(
              productName,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Text(
              price,
              style: const TextStyle(
                color: Colors.green,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              "Produk kesehatan mata berkualitas tinggi untuk menjaga kesehatan penglihatan.",
              textAlign: TextAlign.center,
            ),

            const Spacer(),
          ],
        ),
      ),

      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                icon: const Icon(
                  Icons.shopping_cart,
                ),
                label: const Text("Keranjang"),
                onPressed: () {
                  CartService.addItem(
                    name: productName,
                    price: price,
                  );

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          const CartScreen(),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(width: 10),

            Expanded(
              flex: 2,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      const Color(0xFF4A90E2),
                ),
                icon: const Icon(
                  Icons.flash_on,
                  color: Colors.white,
                ),
                label: const Text(
                  "Beli Sekarang",
                  style: TextStyle(
                    color: Colors.white,
                  ),
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}