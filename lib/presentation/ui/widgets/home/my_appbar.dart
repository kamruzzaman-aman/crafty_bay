import 'package:crafty_bay/presentation/state_holders/auth_controller.dart';
import 'package:crafty_bay/presentation/ui/screens/AuthScreen/create_profile_screen.dart';
import 'package:crafty_bay/presentation/ui/screens/AuthScreen/email_screen.dart';
import 'package:crafty_bay/presentation/ui/widgets/home/craftybay_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

AppBar  myAppBar(BuildContext context) {
  return AppBar(
    leading: Padding(
      padding: const EdgeInsets.only(left: 15),
      child: Image.asset('assets/images/logo.png',fit: BoxFit.contain,),
    ),
    title: craftyBayText(context, fontSize: 25),
    actions: [
      InkWell(
        onTap: () {
          Get.to(() => const ProfileScreen());
        },
        child: Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: CircleAvatar(
              backgroundColor: Colors.grey[200],
              child: const Icon(Icons.person_outline_sharp)),
        ),
      ),
      InkWell(
        onTap: () async {
          await AuthController.clearAuthData();
          Get.offAll(() => const EmailScreen());
        },
        child: Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: CircleAvatar(
              backgroundColor: Colors.grey[200], child: const Icon(Icons.logout)),
        ),
      ),
      InkWell(
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.only(right: 12.0),
          child: CircleAvatar(
              backgroundColor: Colors.grey[200],
              child: const Icon(Icons.add_alert_rounded)),
        ),
      ),
    ],
  );
}