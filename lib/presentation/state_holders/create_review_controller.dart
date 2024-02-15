import 'package:get/get.dart';

import '../../data/service/network_caller.dart';
import '../../data/utilities/urls.dart';
import 'auth_controller.dart';

class CreateReviewController extends GetxController {
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  Future<bool> createReview(String description,String productId,String rating) async {
    Map<String, dynamic> body = {
      "description": description,
      "product_id":productId,
      "rating":rating
    };
    _isLoading = true;
    update();
    try{
      final response = await NetWorkCaller().postRequest(
        url: Urls.createReviewUrl,
        body: body, token: Get.find<AuthController>().token.toString(),
      );
      _isLoading = false;
      if (response.isSuccess) {
        update();
        return true;
      }
      else {
        _errorMessage = response.errorMessage;
        update();
        return false;
      }
    }
    catch(e){
      _errorMessage = e.toString();
      update();
      return false;
    }
  }

}