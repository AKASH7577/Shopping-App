import 'package:get/get.dart';

import '../data/mock_products.dart';
import '../models/product.dart';

class ProductController extends GetxController {

  final RxList<Product> allProducts = <Product>[].obs;

  final RxList<Product> filteredProducts = <Product>[].obs;


  final RxString searchQuery = ''.obs;

 
  final RxString selectedCategory = 'All'.obs;

  @override
  void onInit() {
    super.onInit();

    allProducts.assignAll(products);
    filteredProducts.assignAll(products);
  }

 
  List<String> get categories {
    final categoryList = allProducts
        .map((product) => product.category)
        .toSet()
        .toList();

    categoryList.sort();

    return ['All', ...categoryList];
  }


  void searchProducts(String query) {
    searchQuery.value = query;
    _applyFilters();
  }


  void filterByCategory(String category) {
    selectedCategory.value = category;
    _applyFilters();
  }

 
  void _applyFilters() {
    final query = searchQuery.value.trim().toLowerCase();
    final category = selectedCategory.value;

    final result = allProducts.where((product) {
      final matchesSearch =
          product.name.toLowerCase().contains(query);

      final matchesCategory =
          category == 'All' ||
          product.category == category;

      return matchesSearch && matchesCategory;
    }).toList();

    filteredProducts.assignAll(result);
  }

 
  void clearFilters() {
    searchQuery.value = '';
    selectedCategory.value = 'All';

    filteredProducts.assignAll(allProducts);
  }
}