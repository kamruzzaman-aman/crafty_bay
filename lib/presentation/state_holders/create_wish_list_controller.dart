import 'package:crafty_bay/data/models/wish_list_model.dart';
import 'package:crafty_bay/data/service/network_caller.dart';
import 'package:crafty_bay/data/utilities/urls.dart';
import 'package:crafty_bay/presentation/state_holders/auth_controller.dart';
import 'package:crafty_bay/presentation/state_holders/product_wish_list_controller.dart';
import 'package:get/get.dart';

class CreateWishListController extends GetxController {
  bool _isLoading = false;
  bool isFavorite = false;
  WishListModel _wishListModel = WishListModel();
  WishListModel get wishListModel => _wishListModel;
  bool get isLoading => _isLoading;
  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  Future<bool> createWishList(int id) async {
    isFavorite = false;
    _isLoading = true;
    update();
    final response = await NetWorkCaller().getRequest(
        Urls.createWishListUrl(id), token: Get.find<AuthController>().token);
    _isLoading = false;
    if (response.isSuccess) {
      Get.find<ProductWishListController>().getWishListProduct();
      update();
      return true;
    } else {
      _errorMessage = response.errorMessage;
      update();
      return false;
    }
  }
  void removeWishList(int id) async {
    _isLoading=true;
    update();
    final response = await NetWorkCaller().getRequest(
        Urls.removeWishListUrl(id),token: Get.find<AuthController>().token);
    _isLoading=false;
    if (response.isSuccess) {
      Get.find<ProductWishListController>().getWishListProduct();
      update();
    } else {
      _errorMessage = response.errorMessage;
      update();
    }
  }
}
