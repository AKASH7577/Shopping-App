import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/cart_controller.dart';
import '../controllers/product_details_controller.dart';
import '../models/product.dart';

class ProductDetailsScreen extends StatelessWidget {
  final Product product;

  const ProductDetailsScreen({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {

    final ProductDetailsController detailsController =
        Get.put(
      ProductDetailsController(),
      tag: 'product_${product.id}',
    );

    final CartController cartController =
        Get.find<CartController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),

        actions: [
          IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(Icons.close),
          ),
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                product.image,
                width: double.infinity,
                height: 300,
                fit: BoxFit.cover,

                errorBuilder: (
                  context,
                  error,
                  stackTrace,
                ) {
                  return Container(
                    width: double.infinity,
                    height: 300,
                    color: Colors.grey.shade200,
                    child: const Center(
                      child: Icon(
                        Icons.image_not_supported,
                        size: 60,
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 20),


            Text(
              product.name,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              '₹${product.price.toStringAsFixed(0)}',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 6,
              ),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                product.category,
                style: TextStyle(
                  color: Colors.blue.shade700,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),

            const SizedBox(height: 24),

  
            const Text(
              'Description',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              product.description,
              style: const TextStyle(
                fontSize: 15,
                height: 1.5,
              ),
            ),

            const SizedBox(height: 30),


            const Center(
              child: Text(
                'Quantity',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 10),

            Center(
              child: Obx(
                () => Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey.shade400,
                    ),
                    borderRadius:
                        BorderRadius.circular(10),
                  ),

                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      
                      IconButton(
                        onPressed: () {
                          detailsController
                              .decreaseQuantity();
                        },
                        icon: const Icon(
                          Icons.remove,
                        ),
                      ),

                  
                      SizedBox(
                        width: 45,
                        child: Text(
                          '${detailsController.quantity.value}',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),
                      ),

                      IconButton(
                        onPressed: () {
                          detailsController
                              .increaseQuantity();
                        },
                        icon: const Icon(
                          Icons.add,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 25),

   
            Obx(
              () {
                final total =
                    product.price *
                        detailsController
                            .quantity.value;

                return Center(
                  child: Text(
                    'Total: ₹${total.toStringAsFixed(0)}',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: 20),


            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                  onPressed: () {
                    cartController.addToCart(
                      product,
                      quantity:
                          detailsController
                              .quantity.value,
                    );

                    Get.snackbar(
                      'Cart Updated',
                      '${product.name} added to cart',
                      snackPosition:
                          SnackPosition.BOTTOM,
                      duration: const Duration(seconds: 2),
                    );
                  },

                  icon: const Icon(
                    Icons.shopping_cart,
                  ),

                  label: const Text(
                    'Add to Cart',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            
          ],
        ),
      ),
    );
  }
}