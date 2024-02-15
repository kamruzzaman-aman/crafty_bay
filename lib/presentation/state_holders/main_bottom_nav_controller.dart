 import 'package:get/get.dart';

import '../ui/screens/AuthScreen/email_screen.dart';
import 'auth_controller.dart';

class MainBottomNavController extends GetxController {
  int _currentIndex = 0;
  int get currentIndex => _currentIndex;

  void changeIndex(int index) {
    if(index == 2||index == 3){
      if(Get.find<AuthController>().isUserLoggedIn==false){
        Get.to(() => const EmailScreen());
        return;
      }
      _currentIndex = index;
      update();
      return;
    }
    _currentIndex = index;
    update();
  }
  void backToHome(){
    changeIndex(0);
    update();
  }
 }