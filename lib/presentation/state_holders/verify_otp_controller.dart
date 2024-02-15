import 'dart:developer';

import 'package:crafty_bay/data/service/network_caller.dart';
import 'package:crafty_bay/data/utilities/urls.dart';
import 'package:crafty_bay/presentation/state_holders/auth_controller.dart';
import 'package:crafty_bay/presentation/state_holders/read_profile_controller.dart';
import 'package:get/get.dart';

class VerifyOtpController extends GetxController{
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  String _errorMessage = '';
  String get errorMessage => _errorMessage;
  bool _isProfileCompleted = false;
  bool get isProfileCompleted => _isProfileCompleted;
  String? token;

  Future<bool> verifyOtp(String email, String otp) async {
    _isLoading = true;
    update();
    final response = await NetWorkCaller().getRequest(Urls.verifyOtpUrl(email, otp));
    if (response.isSuccess) {
      token = await response.responseData['data'];
      log('token: $token');
      await Future.delayed(const Duration(seconds: 5), () {
      });
      final responseProfile = await Get.find<ReadProfileController>().readProfile(token!);
      if(responseProfile){
        await Get.find<AuthController>().saveUserDetails(token!, Get.find<ReadProfileController>().userModel);
        _isProfileCompleted = true;
      }
      else{
        _isProfileCompleted = false;

      }
      _isLoading = false;
      update();
      return true;
    }
    else {

      _errorMessage = response.errorMessage;
      _isLoading = false;
      update();
      return false;

    }
  }
}