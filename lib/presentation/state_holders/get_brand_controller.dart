import 'package:get/get.dart';

import '../../data/models/brand_model.dart';
import '../../data/service/network_caller.dart';
import '../../data/utilities/urls.dart';

class BrandController extends GetxController {
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  String _errorMessage = '';
  String get errorMessage => _errorMessage;
  BrandModel _brand = BrandModel();
  BrandModel get brand => _brand;

  Future<bool> getBrandList() async {
    _isLoading = true;
    update();
    final response = await NetWorkCaller().getRequest(
        Urls.brandListUrl);
    _isLoading = false;
    if (response.isSuccess) {
      _brand = BrandModel.fromJson(response.responseData);
      update();
      return true;
    } else {
      _errorMessage = response.errorMessage;
      update();
      return false;
    }
  }
}