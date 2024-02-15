import 'package:get/get.dart';

import '../../data/service/network_caller.dart';
import '../../data/utilities/urls.dart';
import 'auth_controller.dart';

class DeleteCartController extends GetxController{
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  Future<bool> deleteCard(int id) async {
    _isLoading = true;
    update();
    final response = await NetWorkCaller().getRequest(
        Urls.deleteCartListUrl(id), token: Get.find<AuthController>().token);
    _isLoading = false;
    if (response.isSuccess) {
      update();
      return true;
    } else {
      _errorMessage = response.errorMessage;
      update();
      return false;
    }
  }
}