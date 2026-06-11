import 'package:flutter/material.dart';

import 'cart_screen.dart';
import 'product_detail_screen.dart';
import 'cart_service.dart';

class ApotekScreen extends StatefulWidget {
  const ApotekScreen({super.key});

  @override
  State<ApotekScreen> createState() => _ApotekScreenState();
}

class _ApotekScreenState extends State<ApotekScreen> {
  final TextEditingController searchController =
      TextEditingController();

  String searchText = "";

  final List<Map<String, dynamic>> products = [
    {
      "name": "Vitamin Mata",
      "price": "Rp 50.000",
      "icon": Icons.medication,
    },
    {
      "name": "Obat Tetes Mata",
      "price": "Rp 25.000",
      "icon": Icons.remove_red_eye,
    },
    {
      "name": "Insto Regular",
      "price": "Rp 18.000",
      "icon": Icons.water_drop,
    },
    {
      "name": "Insto Dry Eyes",
      "price": "Rp 22.000",
      "icon": Icons.water_drop,
    },
    {
      "name": "Rohto Cool",
      "price": "Rp 20.000",
      "icon": Icons.water_drop,
    },
    {
      "name": "Rohto Ice",
      "price": "Rp 24.000",
      "icon": Icons.water_drop,
    },
    {
      "name": "Vitamin A",
      "price": "Rp 35.000",
      "icon": Icons.medication_liquid,
    },
    {
      "name": "Vitamin C",
      "price": "Rp 30.000",
      "icon": Icons.medication_liquid,
    },
    {
      "name": "Omega 3",
      "price": "Rp 95.000",
      "icon": Icons.favorite,
    },
    {
      "name": "Lutein Plus",
      "price": "Rp 85.000",
      "icon": Icons.health_and_safety,
    },
    {
      "name": "Bilberry Extract",
      "price": "Rp 110.000",
      "icon": Icons.spa,
    },
    {
      "name": "Eye Patch",
      "price": "Rp 28.000",
      "icon": Icons.healing,
    },
    {
      "name": "Lens Cleaner",
      "price": "Rp 15.000",
      "icon": Icons.cleaning_services,
    },
    {
      "name": "Tisu Pembersih Lensa",
      "price": "Rp 12.000",
      "icon": Icons.clean_hands,
    },
    {
      "name": "Kotak Kacamata",
      "price": "Rp 30.000",
      "icon": Icons.inventory_2,
    },
    {
      "name": "Kacamata Baca",
      "price": "Rp 150.000",
      "icon": Icons.visibility,
    },
    {
      "name": "Kacamata Minus",
      "price": "Rp 250.000",
      "icon": Icons.visibility,
    },
    {
      "name": "Blue Light Glasses",
      "price": "Rp 175.000",
      "icon": Icons.visibility,
    },
    {
      "name": "Kacamata Anti Radiasi",
      "price": "Rp 220.000",
      "icon": Icons.visibility,
    },
    {
      "name": "Multivitamin Vision Care",
      "price": "Rp 75.000",
      "icon": Icons.medical_services,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final filteredProducts = products.where((product) {
      return product["name"]
          .toString()
          .toLowerCase()
          .contains(searchText.toLowerCase());
    }).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF5F8FF),

      appBar: AppBar(
        backgroundColor: const Color(0xFF4A90E2),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Apotek VisionMe",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        actions: [
          Stack(
            children: [
              IconButton(
                icon: const Icon(
                  Icons.shopping_cart_outlined,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const CartScreen(),
                    ),
                  ).then((_) {
                    setState(() {});
                  });
                },
              ),

              if (CartService.items.isNotEmpty)
                Positioned(
                  right: 8,
                  top: 6,
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      "${CartService.items.length}",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),

      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: const LinearGradient(
                colors: [
                  Color(0xFF4A90E2),
                  Color(0xFF6BB7FF),
                ],
              ),
            ),
            child: const Row(
              children: [
                Icon(
                  Icons.visibility,
                  color: Colors.white,
                  size: 50,
                ),
                SizedBox(width: 15),
                Expanded(
                  child: Text(
                    "Jaga kesehatan mata dengan produk terbaik dan terpercaya.",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: TextField(
              controller: searchController,
              onChanged: (value) {
                setState(() {
                  searchText = value;
                });
              },
              decoration: InputDecoration(
                hintText: "Cari produk...",
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          const SizedBox(height: 15),

          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "${filteredProducts.length} Produk Tersedia",
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          const SizedBox(height: 10),

          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              itemCount: filteredProducts.length,
              itemBuilder: (context, index) {
                final item = filteredProducts[index];

                return Card(
                  elevation: 3,
                  margin:
                      const EdgeInsets.only(bottom: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(18),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      children: [
                        Container(
                          width: 65,
                          height: 65,
                          decoration: BoxDecoration(
                            color: Colors.blue.shade50,
                            borderRadius:
                                BorderRadius.circular(
                                    15),
                          ),
                          child: Icon(
                            item["icon"],
                            color:
                                const Color(0xFF4A90E2),
                            size: 32,
                          ),
                        ),

                        const SizedBox(width: 15),

                        Expanded(
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment
                                    .start,
                            children: [
                              Text(
                                item["name"],
                                style:
                                    const TextStyle(
                                  fontSize: 16,
                                  fontWeight:
                                      FontWeight.bold,
                                ),
                              ),
                              const SizedBox(
                                  height: 4),
                              Text(
                                item["price"],
                                style:
                                    const TextStyle(
                                  fontSize: 15,
                                  color: Colors.green,
                                  fontWeight:
                                      FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),

                        ElevatedButton(
                          style:
                              ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color(
                                    0xFF4A90E2),
                            shape:
                                RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius
                                      .circular(
                                          12),
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    ProductDetailScreen(
                                  productName:
                                      item["name"],
                                  price:
                                      item["price"],
                                ),
                              ),
                            ).then((_) {
                              setState(() {});
                            });
                          },
                          child: const Text(
                            "Beli",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
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