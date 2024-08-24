import 'package:flutter/material.dart';

import '../../../utils/color/app_colors.dart';
import '../../../utils/style/app_text_style.dart';

Widget rowButtonItem({
  required VoidCallback onTap,
  required bool login,
}) {
  return TextButton(
    onPressed: onTap,
    child: RichText(
      text: TextSpan(
          text: "Sizda account mavjud emasmi.",
          style: AppTextStyle.regular.copyWith(
            fontSize: 12,
          ),
          children: [
            TextSpan(
              text: "Ro'yxatdan o'ting",
              style: AppTextStyle.regular.copyWith(
                fontSize: 12,
                color: AppColors.cFCA34D,
              ),
            ),
          ]
      ),
    ),
  );
}