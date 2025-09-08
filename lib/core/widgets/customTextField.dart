
import 'package:flutter/material.dart';
import 'package:shartflix_movie_app_case/core/constants/app_icons.dart';
import 'package:shartflix_movie_app_case/core/constants/strings.dart';

class CustomTextField extends StatefulWidget {
  final bool hasError;
  final TextEditingController controller;
  final String hinttext;
  final int lenght;
  final Widget prefixIcon;
  final bool showPasswordToggle;

  const CustomTextField({
    super.key,
    required this.controller,
    this.hasError = false,
    required this.hinttext,
    required this.lenght,
    required this.prefixIcon,
    this.showPasswordToggle = false,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLength: widget.lenght,
      controller: widget.controller,
      style: Theme.of(context).textTheme.bodyMedium,
      cursorColor: Theme.of(context).shadowColor,
      cursorHeight: 20,
      obscureText: widget.showPasswordToggle ? _obscureText : false,
      decoration: InputDecoration(
        counterText: "",
        filled: true,
        fillColor: Theme.of(context).canvasColor.withAlpha(100),
        hintText: widget.hinttext,
        hintStyle: TextStyle(
          color: Colors.grey.shade600,
          fontWeight: FontWeight.w400,
          fontFamily: AppFontFamilies.instrumentSansRegular,
        ),
        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.showPasswordToggle
            ? GestureDetector(
                child: _obscureText
                    ? AppIcons.icon(AppIcons.hide)
                    : AppIcons.icon(AppIcons.see),
                onTap: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
              )
            : null,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide(color: Colors.white.withAlpha(20), width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide(color: Colors.white.withAlpha(50), width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(color: Color(0xFFE50914), width: 1.5),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(color: Color(0xFFE50914), width: 1.5),
        ),
      ),
    );
  }
}
