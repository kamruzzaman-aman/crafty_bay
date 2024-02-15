import 'package:get/get.dart';
import '../../data/service/network_caller.dart';
import '../../data/utilities/urls.dart';

class SentEmailOtpController extends GetxController {
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  Future<bool> sentEmailOtp(String email) async {
    _isLoading = true;
    update();
    final response = await NetWorkCaller().getRequest(
        Urls.sentEmailOtpUrl(email));
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
