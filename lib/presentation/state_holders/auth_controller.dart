import 'dart:convert';
import 'dart:developer';

import 'package:crafty_bay/data/models/user_profile.dart';
import 'package:crafty_bay/presentation/ui/screens/AuthScreen/email_screen.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController {
  String? _token;

  String? get token => _token;

  UserProfile? _userProfile;

  UserProfile? get userProfile => _userProfile;

  Future<void> saveUserDetails(String token, UserModel userModel) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('token', token);
    sharedPreferences.setString('userProfile', jsonEncode(userProfile?.toJson()));
    _token = token;
    _userProfile = userProfile;
    log('tokenSaved?: $_token');
   // log('userProfileSaved?: $_userProfile');
  }

  Future<String?> getToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString('token');
  }

  Future<UserProfile?> getUserProfile() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? strUserProfile = sharedPreferences.getString('userProfile');
    return UserProfile.fromJson(jsonDecode(strUserProfile??'{}'));
  }

  Future<void> initialize() async {
    _token = await getToken();
    _userProfile = await getUserProfile();
  }
  bool get isUserLoggedIn => _token != null;

  Future<bool> isLoggedIn() async {
    await initialize();
    return _token != null;
  }

  static Future<void> clearAuthData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.clear();
  }
  static Future<void> goToLogin() async {
    Get.offAll(() => const EmailScreen());
  }
}
