import 'package:crafty_bay/data/models/product_list_model.dart';
import 'package:crafty_bay/data/service/network_caller.dart';
import 'package:crafty_bay/data/utilities/urls.dart';
import 'package:get/get.dart';

class PopularProductController extends GetxController{
  //RemarkProductController({required this.remark});
 // String remark;
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  String _errorMessage = '';
  String get errorMessage => _errorMessage;
  ProductListModel _remarkProductModel=ProductListModel();
  ProductListModel get remarkProductModel=>_remarkProductModel;

  Future<bool> getPopularProduct() async {
    _isLoading = true;
    update();
    final response = await NetWorkCaller().getRequest(Urls.popularProductUrl);
    _isLoading = false;
    if (response.isSuccess) {
      _remarkProductModel = ProductListModel.fromJson(response.responseData);
      update();
      return true;
    } else {
      _errorMessage = response.errorMessage;
      update();
      return false;
    }
  }
}