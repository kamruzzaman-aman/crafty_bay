import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../utility/app_colors.dart';

PinCodeTextField buildPinCodeTextField(BuildContext context,TextEditingController otpController) {
  return PinCodeTextField(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    controller: otpController,
    length: 6,
    obscureText: false,
    animationType: AnimationType.fade,
    pinTheme: PinTheme(
      shape: PinCodeFieldShape.box,
      borderRadius: BorderRadius.circular(5),
      fieldHeight: 50,
      fieldWidth: 40,
      activeFillColor: Colors.white,
      activeColor: Colors.black87,
      selectedFillColor: AppColors.primaryColor,
      selectedColor: Colors.black87,
      inactiveFillColor: Colors.white,
      inactiveColor: Colors.black87,

    ),
    backgroundColor: Colors.transparent,
    enableActiveFill: true,
    onCompleted: (v) {},
    onChanged: (value) {

    },
    beforeTextPaste: (text) {
      return true;
    },
    appContext: context,
  );
}

