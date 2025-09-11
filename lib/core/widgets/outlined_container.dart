import 'package:flutter/material.dart';

import 'dart:ui';

import 'package:shartflix_movie_app_case/core/extensions/theme_extension.dart'; // BackdropFilter için lazım

Widget outlinedContainer(
  BuildContext context,
  Widget child, {
  double borderValue = 14,
}) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(borderValue),
    child: BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            width: 1.5,
            color: context.theme.shadowColor.withAlpha(50),
          ),
          color: context.theme.cardColor.withAlpha(60), // Hafif saydam
          borderRadius: BorderRadius.circular(borderValue),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: child,
      ),
    ),
  );
}
