import 'package:crafty_bay/presentation/ui/utility/app_colors.dart';
import 'package:flutter/material.dart';


RichText craftyBayText(BuildContext context, {double fontSize = 28}) {
  return RichText(
    text: TextSpan(
      text: 'Crafty',
      style: Theme.of(context).textTheme.titleLarge!.copyWith(
          color: AppColors.primaryColor,
          fontStyle: FontStyle.italic,
          fontSize: fontSize),
      children: <TextSpan>[
        TextSpan(
            text: 'Bay',
            style: TextStyle(
                color: Colors.orange,
                fontStyle: FontStyle.italic,
                fontSize: fontSize)),
      ],
    ),
  );
}
