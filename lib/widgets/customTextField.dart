import 'package:flutter/material.dart';
import 'package:shartflix_movie_app_case/core/utils/strings.dart';

class CustomTextField extends StatelessWidget {
  final bool hasError;
  final TextEditingController controller;

  final VoidCallback? onToggleVisibility;
  final String hinttext;
  final int lenght;
  final Widget prefixIcon;

  const CustomTextField({
    super.key,
    required this.controller,
    this.hasError = false,
    this.onToggleVisibility,
    required this.hinttext,
    required this.lenght,
    required this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      width: 354,
      child: TextField(
        maxLength: lenght,
        controller: controller,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          counterText: "",
          filled: true,
          fillColor: const Color(0xFF1E1E1E),
          hintText: hinttext,
          hintStyle: TextStyle(
            color: Colors.grey.shade500,
            fontWeight: FontWeight.w400,
            fontFamily: AppFontFamilies.instrumentSansRegular
          ),
          prefixIcon: prefixIcon,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: Colors.grey.shade800, width: 1.5),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: Colors.grey.shade500, width: 1.5),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: Colors.red, width: 1.5),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: Colors.red, width: 1.5),
          ),
        ),
      ),
    );
  }
}
