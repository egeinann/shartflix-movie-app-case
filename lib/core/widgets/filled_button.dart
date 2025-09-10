import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shartflix_movie_app_case/core/constants/strings.dart';
import 'package:shartflix_movie_app_case/core/extensions/theme_extension.dart';

class CustomFilledButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const CustomFilledButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
     
      decoration: BoxDecoration(
        color: context.theme.highlightColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          overlayColor: Colors.white,
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          minimumSize: Size(25.w, 5.h),
          elevation: 0,
        ),
        child: Text(
          text,
          style: Theme.of(
            context,
          ).textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.w600,
            fontFamily: AppFontFamilies.instrumentSansSemiBold,
          ),
        ),
      ),
    );
  }
}
