import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/cart_controller.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final CartController cartController =
        Get.find<CartController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Cart'),
      ),

      body: Obx(
        () {
     
          if (cartController.cartItems.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.shopping_cart_outlined,
                    size: 70,
                    color: Colors.grey,
                  ),

                  SizedBox(height: 16),

                  Text(
                    'Your cart is empty',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: 8),

                  Text(
                    'Add products to your cart.',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            );
          }

          return Column(
            children: [
            
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: cartController.cartItems.length,
                  itemBuilder: (context, index) {
                    final product = cartController.cartItems[index];

                    final quantity = cartController.quantities[product.id] ?? 1;
                    return Card(
                      margin: const EdgeInsets.only(
                        bottom: 10,
                      ),
                      elevation: 2,

                      child: Padding(
                        padding: const EdgeInsets.all(10),

                        child: Row(
                          children: [
                           
                            ClipRRect(
                              borderRadius:
                                  BorderRadius.circular(8),
                              child: Image.asset(
                                product.image,
                                width: 75,
                                height: 75,
                                fit: BoxFit.cover,

                                errorBuilder:
                                    (context, error, stackTrace) {
                                  return Container(
                                    width: 75,
                                    height: 75,
                                    color: Colors.grey.shade200,
                                    child: const Icon(
                                      Icons
                                          .image_not_supported,
                                    ),
                                  );
                                },
                              ),
                            ),

                            const SizedBox(width: 12),

        
                            Expanded(
                              child: Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    product.name,
                                    maxLines: 1,
                                    overflow:
                                        TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight:
                                          FontWeight.bold,
                                    ),
                                  ),

                                  const SizedBox(height: 5),

                                  Text(
                                    '₹${product.price.toStringAsFixed(0)}',
                                    style: const TextStyle(
                                      fontWeight:
                                          FontWeight.w600,
                                    ),
                                  ),

                                  const SizedBox(height: 8),

                                 
                                  Row(
                                    children: [
                                      Container(
                                        decoration:
                                            BoxDecoration(
                                          border: Border.all(
                                            color: Colors
                                                .grey.shade400,
                                          ),
                                          borderRadius:
                                              BorderRadius
                                                  .circular(8),
                                        ),

                                        child: Row(
                                          children: [
                                          
                                            IconButton(
                                              onPressed: () {
                                                cartController
                                                    .decreaseQuantity(
                                                  product,
                                                );
                                              },
                                              icon: const Icon(
                                                Icons.remove,
                                                size: 18,
                                              ),
                                            ),

                                            Text(
                                              '$quantity',
                                              style:
                                                  const TextStyle(
                                                fontSize: 16,
                                                fontWeight:
                                                    FontWeight.bold,
                                              ),
                                            ),
                                            IconButton(
                                              onPressed: () {
                                                cartController
                                                    .increaseQuantity(
                                                  product,
                                                );
                                              },
                                              icon: const Icon(
                                                Icons.add,
                                                size: 18,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),

                            IconButton(
                              onPressed: () {
                                cartController
                                    .removeFromCart(product);
                              },
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

        
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  border: Border(
                    top: BorderSide(
                      color: Colors.grey.shade300,
                    ),
                  ),
                ),

                child: Column(
                  children: [
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Bill Summary',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    const SizedBox(height: 12),

                
                    Row(
                      mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Subtotal'),

                        Text(
                          '₹${cartController.subtotal.toStringAsFixed(0)}',
                        ),
                      ],
                    ),

                    const SizedBox(height: 8),

                    
                    Row(
                      mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Delivery'),

                        Text(
                          cartController.deliveryCharge == 0
                              ? 'FREE'
                              : '₹${cartController.deliveryCharge.toStringAsFixed(0)}',

                          style: TextStyle(
                            color:
                                cartController.deliveryCharge ==
                                        0
                                    ? Colors.green
                                    : null,
                            fontWeight:
                                FontWeight.w600,
                          ),
                        ),
                      ],
                    ),

                    const Divider(height: 20),

                    
                    Row(
                      mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Total',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        Text(
                          '₹${cartController.totalPrice.toStringAsFixed(0)}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 14),

                    
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          Get.snackbar(
                            'Checkout',
                            'Proceeding to checkout...',
                            snackPosition:
                                SnackPosition.BOTTOM,
                          );
                        },
                        child: const Text(
                          'Checkout',
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
            ],
          );
        },
      ),
    );
  }
}