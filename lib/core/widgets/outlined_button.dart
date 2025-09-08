import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CustomOutlinedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const CustomOutlinedButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        overlayColor: Colors.transparent,
        side: BorderSide(color: Theme.of(context).shadowColor, width: 1.5),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        minimumSize: Size(24.w, 4.h),
      ),
      onPressed: onPressed,
      child: Text(text, style: Theme.of(context).textTheme.bodyLarge),
    );
  }
}
