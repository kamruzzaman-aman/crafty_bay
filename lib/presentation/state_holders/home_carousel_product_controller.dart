import 'package:crafty_bay/data/models/home_carousel_product_model.dart';
import 'package:crafty_bay/data/service/network_caller.dart';
import 'package:crafty_bay/data/utilities/urls.dart';
import 'package:get/get.dart';

class HomeCarouselProductController extends GetxController{
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  String _errorMessage = '';
  String get errorMessage => _errorMessage;
  HomeCarouselProductModel _homeCarouselProductModel = HomeCarouselProductModel();
  HomeCarouselProductModel get homeCarouselProductModel => _homeCarouselProductModel;

  Future<bool> getHomeCarouselProduct() async {
    _isLoading = true;
    update();
    final response = await NetWorkCaller().getRequest(
        Urls.listProductSliderUrl);
    _homeCarouselProductModel = HomeCarouselProductModel.fromJson(response.responseData);
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