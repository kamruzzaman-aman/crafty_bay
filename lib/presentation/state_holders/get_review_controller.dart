import 'package:crafty_bay/data/models/review_model.dart';
import 'package:crafty_bay/data/service/network_caller.dart';
import 'package:crafty_bay/data/utilities/urls.dart';
import 'package:get/get.dart';

class GetReviewController extends GetxController {
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  String _errorMessage = '';
  String get errorMessage => _errorMessage;
  ReviewModel _reviewModel = ReviewModel();
  ReviewModel get reviewModel => _reviewModel;

  Future<bool> getReview(int id) async {
    _isLoading = true;
    update();
    final response = await NetWorkCaller().getRequest(
        Urls.listReviewByProduct(id));
    _isLoading = false;
    if (response.isSuccess) {
      _reviewModel = ReviewModel.fromJson(response.responseData);
      update();
      return true;
    } else {
      _errorMessage = response.errorMessage;
      update();
      return false;
    }
  }
}