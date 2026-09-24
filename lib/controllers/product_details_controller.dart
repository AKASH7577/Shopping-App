import 'package:get/get.dart';

class ProductDetailsController extends GetxController {
  final RxInt quantity = 1.obs;

  void increaseQuantity() {
    quantity.value++;
  }

  void decreaseQuantity() {
    if (quantity.value > 1) {
      quantity.value--;
    }
  }

  void resetQuantity() {
    quantity.value = 1;
  }
}