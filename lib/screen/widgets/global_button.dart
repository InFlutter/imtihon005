import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utils/color/app_colors.dart';
import '../../utils/style/app_text_style.dart';

Widget globalButton({
  required String title,
  required VoidCallback onTap,
  double radius = 5,
  Color color = AppColors.c2C557D,
  TextStyle? style,
  double buttonHeight = 20,
  double buttonWidth = 50,
  bool isLoading = false
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(radius)
      ),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: buttonWidth, vertical: buttonHeight),
        child: Center(
          child: isLoading?const CupertinoActivityIndicator(color: Colors.white,):Text(
            title,
            style:  style ?? AppTextStyle.medium.copyWith(
              color: Colors.white,
            ),
          ),
        ),
      ),
    ),
  );
}