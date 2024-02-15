import 'dart:developer';

import 'package:crafty_bay/data/models/cart_model.dart';
import 'package:crafty_bay/data/service/network_caller.dart';
import 'package:crafty_bay/data/utilities/urls.dart';
import 'package:crafty_bay/presentation/state_holders/auth_controller.dart';
import 'package:crafty_bay/presentation/state_holders/delete_cart_controller.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  bool _isLoading = false;
  String _errorMessage = '';
  RxDouble _totalAmount = 0.0.obs;
  CartModel _cartModel = CartModel();

  CartModel get cartModel => _cartModel;

  bool get isLoading => _isLoading;

  String get errorMessage => _errorMessage;

  RxDouble get totalAmount => _totalAmount;

  Future<bool> getCart() async {
    _isLoading = true;
    update();
    final response = await NetWorkCaller()
        .getRequest(Urls.getCartUrl, token: Get.find<AuthController>().token);
    _isLoading = false;
    if (response.isSuccess) {
      _cartModel = CartModel.fromJson(response.responseData);
      _totalAmount.value = calculateTotalPrice();
      update();
      return true;
    } else {
      _errorMessage = response.errorMessage;
      update();
      return false;
    }
  }

  void updateQuantity(int id, int quantity) {
    log('id: $id, qty: $quantity');
    _cartModel.cartList?.firstWhere((element) => element.id == id).qty =
        quantity;
    _totalAmount.value = calculateTotalPrice();
  }

  double calculateTotalPrice() {
    double total = 0;
    for (CartItem item in _cartModel.cartList ?? []) {
      log(item.product?.price.toString()??"0");
      total += (double.tryParse(item.product?.price ?? '0') ?? 0) * item.qty;
    }
    return total;
  }

  void removeItem(int id) async {
    _isLoading=true;
    update();
   final result = await Get.find<DeleteCartController>().deleteCard(id);
   _isLoading=false;
   if(result) {
     log(result.toString());
     await getCart();
     update();
   }
   else{
     log('error');
   }
  }
}
