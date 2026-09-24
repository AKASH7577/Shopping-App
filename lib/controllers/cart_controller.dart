import 'package:get/get.dart';

import '../models/product.dart';

class CartController extends GetxController {
 
  final RxList<Product> cartItems = <Product>[].obs;


  final RxMap<int, int> quantities = <int, int>{}.obs;


  void addToCart(
    Product product, {
    int quantity = 1,
  }) {
    if (!cartItems.any((item) => item.id == product.id)) {
      cartItems.add(product);
      quantities[product.id] = quantity;
    } else {
      quantities[product.id] =
          (quantities[product.id] ?? 0) + quantity;
    }

    quantities.refresh();

    Get.snackbar(
      'Added to Cart',
      '${product.name} added successfully',
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 2),
    );
  }

 
  void increaseQuantity(Product product) {
    quantities[product.id] =
        (quantities[product.id] ?? 0) + 1;

    quantities.refresh();
  }


  void decreaseQuantity(Product product) {
    final currentQuantity =
        quantities[product.id] ?? 1;

    if (currentQuantity > 1) {
      quantities[product.id] =
          currentQuantity - 1;

      quantities.refresh();
    } else {
      removeFromCart(product);
    }
  }


  void removeFromCart(Product product) {
    cartItems.removeWhere(
      (item) => item.id == product.id,
    );

    quantities.remove(product.id);

    quantities.refresh();
  }


  void clearCart() {
    cartItems.clear();
    quantities.clear();
  }


  int get cartCount {
    int count = 0;

    for (final product in cartItems) {
      count += quantities[product.id] ?? 1;
    }

    return count;
  }


  double get subtotal {
    double total = 0;

    for (final product in cartItems) {
      final quantity =
          quantities[product.id] ?? 1;

      total += product.price * quantity;
    }

    return total;
  }

  
  double get deliveryCharge {
    if (subtotal >= 1000) {
      return 0;
    }

    return 50;
  }

  double get totalPrice {
    return subtotal + deliveryCharge;
  }
}