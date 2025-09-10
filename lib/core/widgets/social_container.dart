// *** KOD TEKRARINI AZALTMAK İÇİN BİR FONKSİYON ***
import 'package:flutter/material.dart';
import 'package:shartflix_movie_app_case/core/constants/app_icons.dart';
import 'package:shartflix_movie_app_case/core/extensions/theme_extension.dart';

Widget socialContainer(BuildContext context,String iconPath, VoidCallback onTap) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      height: 60,
      width: 60,
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        border: Border.all(
          color: context.theme.shadowColor.withAlpha(50),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: AppIcons.icon(iconPath),
    ),
  );
}
