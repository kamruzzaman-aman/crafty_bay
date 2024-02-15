
import 'package:crafty_bay/presentation/state_holders/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:crafty_bay/presentation/ui/screens/CraftyBayScreen/bottom_nav_screen.dart';
import 'package:crafty_bay/presentation/ui/utility/app_colors.dart';
import 'package:crafty_bay/presentation/ui/utility/assets_path.dart';
import 'package:get/get.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  //final bool isLogin = false;

  @override
  void initState() {
    super.initState();
    moveToNextScreen();
  }

  void moveToNextScreen() async {
    await Get.find<AuthController>().initialize();
    await Future.delayed(const Duration(seconds: 4))
        .then((value) => Get.offAll(() => const BottomNavScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Image.asset(
                AssetsPath.applogo,
                width: 100,
              ),
            ),
            const SizedBox(height: 10),
            // craftyBayText(context),
            const Spacer(),
            const CircularProgressIndicator(
              color: AppColors.primaryColor,
            ),
            const SizedBox(height: 20),
            const Text('Version 1.0'),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
