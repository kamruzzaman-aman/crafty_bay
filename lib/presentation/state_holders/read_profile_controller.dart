import 'package:crafty_bay/data/models/user_profile.dart';
import 'package:crafty_bay/data/service/network_caller.dart';
import 'package:crafty_bay/data/utilities/urls.dart';
import 'package:get/get.dart';

class ReadProfileController extends GetxController {
  UserModel _userModel = UserModel();
  UserModel get userModel => _userModel;

  Future<bool> readProfile(String token) async {
    final response = await NetWorkCaller().getRequest(
        Urls.readProfileUrl, token: token);
    if (response.isSuccess) {
      if (response.responseData['data']==null) {
        return false;
      }
      else {
        _userModel = UserModel.fromJson(response.responseData['data']);
        return true;
      }
    }
    else{
      return false;
    }
  }
}