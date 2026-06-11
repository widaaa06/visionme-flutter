class CartService {
  static final List<Map<String, dynamic>> items = [];

  static void addItem({
    required String name,
    required String price,
  }) {
    items.add({
      "name": name,
      "price": price,
    });
  }

  static void removeItem(int index) {
    items.removeAt(index);
  }

  static void clearCart() {
    items.clear();
  }
}