import 'package:crafty_bay/data/service/network_caller.dart';
import 'package:crafty_bay/data/utilities/urls.dart';
import 'package:crafty_bay/presentation/state_holders/auth_controller.dart';
import 'package:crafty_bay/presentation/state_holders/verify_otp_controller.dart';
import 'package:get/get.dart';
import 'package:crafty_bay/data/models/create_profile_parameter_model.dart';
import 'package:crafty_bay/data/models/user_profile.dart';

class CreateProfileController extends GetxController {
  bool _isLoading = false;

  bool get isLoading => _isLoading;
  String _errorMessage = '';

  String get errorMessage => _errorMessage;

  Future<bool> createProfile(CreateProfileParameter createProfileParameter) async {
    _isLoading = true;
    update();
    final response = await NetWorkCaller().postRequest(
      url: Urls.createProfileUrl,
      body: createProfileParameter.toJson(),
      token: Get.find<VerifyOtpController>().token?? Get.find<AuthController>().token!,
    );
    _isLoading = false;
    if (response.isSuccess) {
      await Get.find<AuthController>().saveUserDetails(
          Get.find<VerifyOtpController>().token??Get.find<AuthController>().token!,
          UserModel.fromJson(response.responseData['data']));
      update();
      return true;
    } else {
      _errorMessage = 'profile Creation Failed';
      update();
      return false;
    }
  }
}
