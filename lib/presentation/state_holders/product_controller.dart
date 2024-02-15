import 'package:crafty_bay/data/models/product_list_model.dart';
import 'package:crafty_bay/data/service/network_caller.dart';
import 'package:crafty_bay/data/utilities/urls.dart';
import 'package:get/get.dart';

class ProductController extends GetxController{
  //RemarkProductController({required this.remark});
  // String remark;
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  String _errorMessage = '';
  String get errorMessage => _errorMessage;
  ProductListModel _productModel=ProductListModel();
  ProductListModel get productModel=>_productModel;

  Future<bool> getProduct(int id) async {
    _isLoading = true;
    update();
    final response = await NetWorkCaller().getRequest(Urls.ListProductByCategoryIdUrl(id));
    _isLoading = false;
    if (response.isSuccess) {
      _productModel = ProductListModel.fromJson(response.responseData);
      update();
      return true;
    } else {
      _errorMessage = response.errorMessage;
      update();
      return false;
    }
  }
}