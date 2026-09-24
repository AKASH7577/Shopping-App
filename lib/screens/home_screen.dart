import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/cart_controller.dart';
import '../controllers/product_controller.dart';
import '../widgets/product_card.dart';
import 'cart_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ProductController productController =
        Get.find<ProductController>();

    final CartController cartController =
        Get.find<CartController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping App'),

        actions: [
         
          Obx(
            () => Stack(
              children: [
                IconButton(
                  onPressed: () {
                    Get.to(
                      () => const CartScreen(),
                    );
                  },
                  icon: const Icon(
                    Icons.shopping_cart,
                  ),
                ),

               
                if (cartController.cartCount > 0)
                  Positioned(
                    right: 5,
                    top: 5,
                    child: Container(
                      padding:
                          const EdgeInsets.all(4),
                      decoration:
                          const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        '${cartController.cartCount}',
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
          ),
        ],
      ),

      body: Column(
        children: [
        
          Padding(
            padding: const EdgeInsets.fromLTRB(
              12,
              12,
              12,
              6,
            ),
            child: TextField(
              onChanged: (value) {
                productController.searchProducts(
                  value,
                );
              },

              decoration: InputDecoration(
                hintText: 'Search products by name...',
                prefixIcon: const Icon(
                  Icons.search,
                ),

                suffixIcon: Obx(
                  () {
                    if (productController
                        .searchQuery
                        .value
                        .isEmpty) {
                      return const SizedBox.shrink();
                    }

                    return IconButton(
                      onPressed: () {
                        productController
                            .clearFilters();
                      },
                      icon: const Icon(
                        Icons.clear,
                      ),
                    );
                  },
                ),

                border: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(12),
                ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 6,
            ),
            child: Row(
              children: [
           
                Expanded(
                  child: Obx(
                    () => DropdownButtonFormField<
                        String>(
                      value: productController
                          .selectedCategory.value,

                      decoration:
                          InputDecoration(
                        labelText: 'Category',
                        border:
                            OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(
                            12,
                          ),
                        ),
                      ),

                      items: productController
                          .categories
                          .map(
                        (category) {
                          return DropdownMenuItem<
                              String>(
                            value: category,
                            child: Text(category),
                          );
                        },
                      ).toList(),

                      onChanged: (value) {
                        if (value != null) {
                          productController
                              .filterByCategory(
                            value,
                          );
                        }
                      },
                    ),
                  ),
                ),

                const SizedBox(width: 10),

              
                OutlinedButton.icon(
                  onPressed: () {
                    productController
                        .clearFilters();
                  },
                  icon: const Icon(
                    Icons.clear_all,
                  ),
                  label: const Text('Clear'),
                ),
              ],
            ),
          ),

   
          Padding(
            padding: const EdgeInsets.fromLTRB(
              12,
              4,
              12,
              4,
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Obx(
                () => Text(
                  '${productController.filteredProducts.length} products found',
                  style: TextStyle(
                    color: Colors.grey.shade700,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),


          Expanded(
            child: Obx(
              () {
                final products =
                    productController.filteredProducts;

                
                if (products.isEmpty) {
                  return const Center(
                    child: Column(
                      mainAxisAlignment:
                          MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.search_off,
                          size: 60,
                          color: Colors.grey,
                        ),

                        SizedBox(height: 12),

                        Text(
                          'No products found',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),

                        SizedBox(height: 5),

                        Text(
                          'Try another search or category.',
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  );
                }

                return GridView.builder(
                  padding:
                      const EdgeInsets.all(12),

                  gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 0.65,
                  ),

                  itemCount: products.length,

                  itemBuilder:
                      (context, index) {
                    final product =
                        products[index];

                    return ProductCard(
                      product: product,
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}